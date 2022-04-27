import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterone/games/binchgame/components/level.dart';

enum Moving {
  Left,
  Up,
  Right,
  Down,
}

class BinchGame extends FlameGame
    with KeyboardEvents, TapDetector, HasCollisionDetection {
  late final Ember sprite = Ember(
    position: Vector2(150, 200),
  )..add(
      ColorEffect(
        Colors.blue,
        Offset(0.0, 0.8),
        EffectController(
          duration: 1.5,
          reverseDuration: 1,
          curve: Curves.bounceInOut,
        ),
      ),
    );

  static const int speed = 200;
  final Vector2 velocity = Vector2.zero();
  late SpriteComponent bg = SpriteComponent();
  TextPaint dialogTextPaint = TextPaint(
    style: TextStyle(fontSize: 30, color: Colors.red),
  );
  TextComponent instructions = TextComponent();
  late int number;

  @override
  Future<void> onLoad() async {
    add(ScreenHitbox());
    await super.onLoad();
    add(bg
      ..sprite = await loadSprite('car.png')
      ..size = size);
    add(sprite);
    instructions
      ..text = 'This is text'
      ..textRenderer = TextPaint(
        style: TextStyle(color: Color.fromARGB(255, 234, 229, 228)),
      )
      ..x = 20
      ..y = 20;
    add(instructions);
  }

  @override
  void update(double dt) {
    super.update(dt);
    final displacement = velocity * (speed * dt);
    sprite.position.add(displacement);
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;
    if (event.logicalKey == LogicalKeyboardKey.keyA) {
      velocity.x = isKeyDown ? -1 : 0;

      number = 0;
    } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
      velocity.x = isKeyDown ? 1 : 0;

      number = 2;
    } else if (event.logicalKey == LogicalKeyboardKey.keyW) {
      velocity.y = isKeyDown ? -1 : 0;

      number = 1;
    } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
      velocity.y = isKeyDown ? 1 : 0;

      number = 3;
    }
    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    dialogTextPaint.render(
      canvas,
      '${Moving.values.elementAt(number)}',
      Vector2(sprite.x - 50, sprite.y - 80),
    );
  }
}
