import 'package:flutter/material.dart';

/// Reveals [text] word-by-word: each word fades in and rises from below,
/// with a slight stagger so it feels alive rather than instant. Once
/// fully revealed, a static gradient is applied to the whole text via
/// ShaderMask — rich and intentional, not a moving sweep.
class GradientRevealText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final TextAlign textAlign;
  final List<Color> gradientColors;
  final Duration delay;
  final Duration wordStagger;
  final Duration wordDuration;
  final VoidCallback? onComplete;

  const GradientRevealText({
    super.key,
    required this.text,
    required this.style,
    required this.gradientColors,
    this.textAlign = TextAlign.left,
    this.delay = Duration.zero,
    this.wordStagger = const Duration(milliseconds: 140),
    this.wordDuration = const Duration(milliseconds: 550),
    this.onComplete,
  });

  @override
  State<GradientRevealText> createState() => _GradientRevealTextState();
}

class _GradientRevealTextState extends State<GradientRevealText>
    with SingleTickerProviderStateMixin {
  late List<String> _words;
  late AnimationController _controller;
  bool _completedCalled = false;

  @override
  void initState() {
    super.initState();
    _words = widget.text.split(' ');

    // Total timeline covers the last word's stagger + its own duration.
    final totalMs = widget.wordStagger.inMilliseconds * (_words.length - 1) +
        widget.wordDuration.inMilliseconds;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: totalMs),
    )..addListener(() {
        if (!_completedCalled && _controller.value == 1.0) {
          _completedCalled = true;
          widget.onComplete?.call();
        }
      });

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Returns the fade/rise progress (0-1) for word at [index] given the
  /// overall controller value, based on its staggered start time.
  double _progressFor(int index) {
    final totalMs = _controller.duration!.inMilliseconds;
    final startMs = widget.wordStagger.inMilliseconds * index;
    final endMs = startMs + widget.wordDuration.inMilliseconds;
    final nowMs = _controller.value * totalMs;
    if (nowMs <= startMs) return 0;
    if (nowMs >= endMs) return 1;
    return (nowMs - startMs) / (endMs - startMs);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final allRevealed = _controller.value == 1.0;

        final content = Wrap(
          alignment: widget.textAlign == TextAlign.center
              ? WrapAlignment.center
              : WrapAlignment.start,
          children: List.generate(_words.length, (i) {
            final t = Curves.easeOutCubic.transform(_progressFor(i));
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Opacity(
                opacity: t,
                child: Transform.translate(
                  offset: Offset(0, (1 - t) * 18),
                  child: Text(
                    _words[i],
                    style: widget.style.copyWith(
                      color: allRevealed ? null : Colors.white,
                    ),
                  ),
                ),
              ),
            );
          }),
        );

        if (!allRevealed) return content;

        // Once fully revealed, apply a static rich gradient fill.
        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: widget.gradientColors,
          ).createShader(bounds),
          child: content,
        );
      },
    );
  }
}

/// Reveals [text] one character at a time, like it's being typed.
/// Calls [onComplete] once when the full text has been revealed.
class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final TextAlign textAlign;
  final Duration charDuration;
  final Duration delay;
  final VoidCallback? onComplete;
  final bool showCursor;

  const TypewriterText({
    super.key,
    required this.text,
    required this.style,
    this.textAlign = TextAlign.left,
    this.charDuration = const Duration(milliseconds: 35),
    this.delay = Duration.zero,
    this.onComplete,
    this.showCursor = true,
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText>
    with SingleTickerProviderStateMixin {
  int _charCount = 0;
  bool _typingDone = false;
  late AnimationController _blinkController;

  @override
  void initState() {
    super.initState();
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..addListener(() {
        setState(() {});
      });

    Future.delayed(widget.delay, _startTyping);
  }

  void _startTyping() {
    if (!mounted) return;
    _tick();
  }

  void _tick() {
    if (!mounted) return;
    if (_charCount >= widget.text.length) {
      setState(() => _typingDone = true);
      widget.onComplete?.call();
      _blinkController.repeat(reverse: true);
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) _blinkController.stop();
      });
      return;
    }
    setState(() => _charCount++);
    Future.delayed(widget.charDuration, _tick);
  }

  @override
  void dispose() {
    _blinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visibleText = widget.text.substring(0, _charCount);
    return RichText(
      textAlign: widget.textAlign,
      text: TextSpan(
        style: widget.style,
        children: [
          TextSpan(text: visibleText),
          if (widget.showCursor)
            TextSpan(
              text: "|",
              style: widget.style.copyWith(
                color: widget.style.color?.withValues(
                  alpha: _typingDone ? _blinkController.value : 1.0,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Fades and slightly rises into view after [delay]. A small, reusable
/// building block for staggering the remaining hero content so each
/// piece arrives with its own breathing room instead of all at once.
class RevealOnDelay extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final double riseDistance;

  const RevealOnDelay({
    super.key,
    required this.child,
    required this.delay,
    this.duration = const Duration(milliseconds: 550),
    this.riseDistance = 16,
  });

  @override
  State<RevealOnDelay> createState() => _RevealOnDelayState();
}

class _RevealOnDelayState extends State<RevealOnDelay> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1 : 0,
      duration: widget.duration,
      curve: Curves.easeOut,
      child: AnimatedSlide(
        offset: _visible ? Offset.zero : Offset(0, widget.riseDistance / 100),
        duration: widget.duration,
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}