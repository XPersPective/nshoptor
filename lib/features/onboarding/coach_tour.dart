import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

import '../../core/l10n/generated/app_localizations.dart';

/// Coach-mark tour over the real UI (F40, PB-201). Screens wrap tour targets
/// in [TourAnchor]; [runCoachTour] dims the screen, cuts a highlighted hole
/// around each visible target and shows a short card with Next/Back/Skip.
/// No package: the scrim, ring and card are drawn here.

/// Stable target ids shared by screens and tour steps.
abstract final class TourTargets {
  static const listsNew = 'lists.new';
  static const listsReceipt = 'lists.receipt';
  static const listsTabs = 'lists.tabs';
  static const listsDiscover = 'lists.discover';
  static const listsPlan = 'lists.plan';
  static const listsHelp = 'lists.help';
  static const detailTotals = 'detail.totals';
  static const detailItems = 'detail.items';
  static const detailAdd = 'detail.add';
  static const detailReceipt = 'detail.receipt';
}

/// Marks [child] as a tour target. It adds no layout of its own.
class TourAnchor extends StatefulWidget {
  const TourAnchor({super.key, required this.id, required this.child});

  final String id;
  final Widget child;

  /// Most recently mounted, currently visible anchor for [id].
  static BuildContext? find(String id) {
    final states = _registry[id];
    if (states == null) return null;
    for (final state in states.reversed) {
      if (!state.mounted || !state._visible) continue;
      final box = state.context.findRenderObject();
      if (box is RenderBox && box.attached && box.hasSize) {
        return state.context;
      }
    }
    return null;
  }

  static final _registry = <String, List<_TourAnchorState>>{};

  @override
  State<TourAnchor> createState() => _TourAnchorState();
}

class _TourAnchorState extends State<TourAnchor> {
  // Hidden tabs (IndexedStack) and routes below an opaque page disable
  // tickers; such anchors are laid out but not on screen.
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    TourAnchor._registry.putIfAbsent(widget.id, () => []).add(this);
  }

  @override
  void didUpdateWidget(TourAnchor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.id != widget.id) {
      TourAnchor._registry[oldWidget.id]?.remove(this);
      TourAnchor._registry.putIfAbsent(widget.id, () => []).add(this);
    }
  }

  @override
  void dispose() {
    TourAnchor._registry[widget.id]?.remove(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _visible = TickerMode.valuesOf(context).enabled;
    return widget.child;
  }
}

/// Lets a screen deep in the tree (Settings tab) ask the home shell to show
/// the lists tab and run the tour over it.
class GuidedTourHost extends InheritedWidget {
  const GuidedTourHost({super.key, required this.start, required super.child});

  final Future<void> Function() start;

  static GuidedTourHost? maybeOf(BuildContext context) =>
      context.getInheritedWidgetOfExactType<GuidedTourHost>();

  @override
  bool updateShouldNotify(GuidedTourHost oldWidget) => false;
}

class TourStep {
  const TourStep({
    required this.icon,
    required this.title,
    required this.body,
    this.target,
    this.visual,
    this.optional = false,
  });

  final IconData icon;
  final String title;
  final String body;

  /// [TourTargets] id; null shows a centered card.
  final String? target;
  final Widget? visual;

  /// Dropped when its target is not on screen (for example Discover in a
  /// build without it); otherwise a missing target shows a centered card.
  final bool optional;
}

enum TourOutcome {
  /// Every step was seen.
  finished,

  /// Skip pressed.
  skipped,

  /// System back: the tour stays available.
  dismissed,
}

/// Shows [steps] over the current screen. Waits for the screen's entry
/// transition so highlights match the settled layout.
Future<TourOutcome> runCoachTour(
  BuildContext context,
  List<TourStep> steps,
) async {
  final animation = ModalRoute.of(context)?.animation;
  if (animation != null && animation.status != AnimationStatus.completed) {
    final done = Completer<void>();
    void listener(AnimationStatus status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (!done.isCompleted) done.complete();
      }
    }

    animation.addStatusListener(listener);
    await done.future;
    animation.removeStatusListener(listener);
  }
  if (!context.mounted) return TourOutcome.dismissed;
  final shown = [
    for (final step in steps)
      if (!step.optional ||
          (step.target != null && TourAnchor.find(step.target!) != null))
        step,
  ];
  if (shown.isEmpty) return TourOutcome.dismissed;
  final reduceMotion = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
  final outcome = await Navigator.of(context)
      .push<TourOutcome>(_CoachRoute(steps: shown, reduceMotion: reduceMotion));
  return outcome ?? TourOutcome.dismissed;
}

class _CoachRoute extends PopupRoute<TourOutcome> {
  _CoachRoute({required this.steps, required this.reduceMotion});

  final List<TourStep> steps;
  final bool reduceMotion;

  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => false;

  @override
  String? get barrierLabel => null;

  @override
  Duration get transitionDuration =>
      reduceMotion ? Duration.zero : const Duration(milliseconds: 220);

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) => _CoachTour(steps: steps);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) => FadeTransition(
    opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
    child: child,
  );
}

class _CoachTour extends StatefulWidget {
  const _CoachTour({required this.steps});

  final List<TourStep> steps;

  @override
  State<_CoachTour> createState() => _CoachTourState();
}

class _CoachTourState extends State<_CoachTour> {
  int _index = 0;
  Rect? _rect;
  bool _started = false;

  TourStep get _step => widget.steps[_index];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_started) {
      _started = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _settle());
    }
  }

  bool get _reduceMotion =>
      MediaQuery.maybeDisableAnimationsOf(context) ?? false;

  Future<void> _go(int index) async {
    setState(() => _index = index);
    await _settle();
  }

  /// Scrolls the target into view, measures it and announces the step.
  Future<void> _settle() async {
    final target = _step.target == null ? null : TourAnchor.find(_step.target!);
    if (target != null) {
      await Scrollable.ensureVisible(
        target,
        alignment: 0.3,
        duration: _reduceMotion
            ? Duration.zero
            : const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
      );
    }
    if (!mounted) return;
    _measure();
    final view = View.maybeOf(context);
    if (view != null) {
      unawaited(
        SemanticsService.sendAnnouncement(
          view,
          '${_index + 1} / ${widget.steps.length}. ${_step.title}. ${_step.body}',
          Directionality.of(context),
        ),
      );
    }
  }

  void _measure() {
    final rect = _targetRect();
    if (rect != _rect) setState(() => _rect = rect);
  }

  Rect? _targetRect() {
    final id = _step.target;
    if (id == null) return null;
    final target = TourAnchor.find(id);
    final me = context.findRenderObject();
    final box = target?.findRenderObject();
    if (me is! RenderBox || !me.hasSize || box is! RenderBox) return null;
    final topLeft = me.globalToLocal(box.localToGlobal(Offset.zero));
    final rect = topLeft & box.size;
    final bounds = Offset.zero & me.size;
    if (!rect.overlaps(bounds)) return null;
    return rect.intersect(bounds);
  }

  void _finish(TourOutcome outcome) => Navigator.of(context).pop(outcome);

  @override
  Widget build(BuildContext context) {
    // Re-measure after layout changes (rotation, keyboard, text scale).
    MediaQuery.sizeOf(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _measure();
    });
    final scheme = Theme.of(context).colorScheme;
    final duration = _reduceMotion
        ? Duration.zero
        : const Duration(milliseconds: 260);
    final padding = MediaQuery.paddingOf(context);
    final hole = _rect?.inflate(6);
    return BlockSemantics(
      child: Material(
        type: MaterialType.transparency,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final size = constraints.biggest;
            return Stack(
              key: const Key('coach_tour'),
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {},
                    child: TweenAnimationBuilder<Rect?>(
                      // No target: the hole collapses to the centre.
                      tween: RectTween(
                        end:
                            hole ??
                            Rect.fromCenter(
                              center: size.center(Offset.zero),
                              width: 0,
                              height: 0,
                            ),
                      ),
                      duration: duration,
                      curve: Curves.easeOutCubic,
                      builder: (context, rect, _) => CustomPaint(
                        key: const Key('coach_tour_scrim'),
                        painter: _ScrimPainter(
                          hole: rect,
                          scrim: Colors.black.withValues(alpha: 0.62),
                          ring: scheme.primary,
                          glow: scheme.primaryContainer,
                        ),
                      ),
                    ),
                  ),
                ),
                if (hole != null)
                  Positioned.fromRect(
                    rect: hole,
                    child: const IgnorePointer(
                      child: SizedBox.expand(key: Key('coach_tour_highlight')),
                    ),
                  ),
                _placeCard(size, padding, hole),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _placeCard(Size size, EdgeInsets padding, Rect? hole) {
    const gap = 12.0;
    final card = _card();
    final maxWidth = (size.width - 32).clamp(0.0, 420.0);
    if (hole != null) {
      final above = hole.top - padding.top - gap * 2;
      final below = size.height - hole.bottom - padding.bottom - gap * 2;
      final useBelow = below >= above;
      final room = useBelow ? below : above;
      if (room >= 220) {
        return Positioned(
          left: 16,
          right: 16,
          top: useBelow ? hole.bottom + gap : null,
          bottom: useBelow ? null : size.height - hole.top + gap,
          child: Align(
            alignment: useBelow ? Alignment.topCenter : Alignment.bottomCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: room),
              child: card,
            ),
          ),
        );
      }
    }
    return Positioned.fill(
      child: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: card,
          ),
        ),
      ),
    );
  }

  Widget _card() {
    final l10n = AppLocalizations.of(context);
    final material = MaterialLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final step = _step;
    final total = widget.steps.length;
    final last = _index == total - 1;
    final progress = '${_index + 1} / $total';
    const buttonSize = Size(48, 48);
    return Semantics(
      container: true,
      scopesRoute: true,
      namesRoute: true,
      explicitChildNodes: true,
      label: l10n.howToUseLabel,
      child: Material(
        key: const Key('first_run_guide'),
        color: scheme.surfaceContainerHigh,
        elevation: 8,
        shadowColor: Colors.black54,
        borderRadius: BorderRadius.circular(24),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Text scrolls; the buttons stay reachable at any text size.
            Flexible(
              child: SingleChildScrollView(
                key: ValueKey('coach_tour_step_$_index'),
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: scheme.primaryContainer,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            step.icon,
                            color: scheme.onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Semantics(
                                header: true,
                                child: Text(
                                  step.title,
                                  key: const Key('coach_tour_title'),
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Semantics(
                                label: l10n.howToUseLabel,
                                value: progress,
                                child: ExcludeSemantics(
                                  child: Text(
                                    progress,
                                    key: const Key('first_run_guide_progress'),
                                    style: theme.textTheme.labelMedium
                                        ?.copyWith(
                                          color: scheme.onSurfaceVariant,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ExcludeSemantics(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: TweenAnimationBuilder<double>(
                          tween: Tween(end: (_index + 1) / total),
                          duration: _reduceMotion
                              ? Duration.zero
                              : const Duration(milliseconds: 260),
                          builder: (context, value, _) =>
                              LinearProgressIndicator(
                                value: value,
                                minHeight: 4,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(step.body, style: theme.textTheme.bodyMedium),
                    if (step.visual != null) ...[
                      const SizedBox(height: 12),
                      step.visual!,
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
              child: OverflowBar(
                alignment: MainAxisAlignment.end,
                overflowAlignment: OverflowBarAlignment.end,
                spacing: 4,
                children: [
                  if (!last)
                    TextButton(
                      key: const Key('first_run_guide_close'),
                      style: TextButton.styleFrom(minimumSize: buttonSize),
                      onPressed: () => _finish(TourOutcome.skipped),
                      child: Text(l10n.tourSkip),
                    ),
                  if (_index > 0)
                    TextButton(
                      key: const Key('first_run_guide_back'),
                      style: TextButton.styleFrom(minimumSize: buttonSize),
                      onPressed: () => _go(_index - 1),
                      child: Text(material.backButtonTooltip),
                    ),
                  FilledButton(
                    key: const Key('first_run_guide_next'),
                    style: FilledButton.styleFrom(minimumSize: buttonSize),
                    onPressed: last
                        ? () => _finish(TourOutcome.finished)
                        : () => _go(_index + 1),
                    child: Text(last ? l10n.guideDone : l10n.guideNext),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScrimPainter extends CustomPainter {
  _ScrimPainter({
    required this.hole,
    required this.scrim,
    required this.ring,
    required this.glow,
  });

  final Rect? hole;
  final Color scrim;
  final Color ring;
  final Color glow;

  @override
  void paint(Canvas canvas, Size size) {
    final full = Path()..addRect(Offset.zero & size);
    final hole = this.hole;
    if (hole == null || hole.width < 1 || hole.height < 1) {
      canvas.drawPath(full, Paint()..color = scrim);
      return;
    }
    final radius = Radius.circular((hole.shortestSide / 2).clamp(8.0, 20.0));
    final rrect = RRect.fromRectAndRadius(hole, radius);
    canvas.drawPath(
      Path.combine(PathOperation.difference, full, Path()..addRRect(rrect)),
      Paint()..color = scrim,
    );
    canvas.drawRRect(
      rrect.inflate(4),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..color = glow.withValues(alpha: 0.45),
    );
    canvas.drawRRect(
      rrect,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..color = ring,
    );
  }

  @override
  bool shouldRepaint(_ScrimPainter old) =>
      old.hole != hole ||
      old.scrim != scrim ||
      old.ring != ring ||
      old.glow != glow;
}
