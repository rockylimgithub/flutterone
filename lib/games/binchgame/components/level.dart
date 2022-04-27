import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class Ember<T extends FlameGame> extends SpriteAnimationComponent
    with HasGameRef<T>, CollisionCallbacks {
  Ember({
    Vector2? position,
    Vector2? size,
    int? priority,
  }) : super(
          position: position,
          size: size ?? Vector2(50, 50),
          priority: priority,
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    animation = await gameRef.loadSpriteAnimation(
      'animations/ember.png',
      SpriteAnimationData.sequenced(
          amount: 3, stepTime: 0.15, textureSize: Vector2.all(16)),
    );
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    add(RectangleHitbox());
  }
}
