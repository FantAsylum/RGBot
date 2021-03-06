package io.github.fantasylum.rgbot.actors

import com.badlogic.gdx.graphics.g2d.Batch
import com.badlogic.gdx.graphics.g2d.ParticleEffect
import com.badlogic.gdx.math.Vector2
import com.badlogic.gdx.scenes.scene2d.Actor
import io.github.fantasylum.rgbot.Color
import io.github.fantasylum.rgbot.Color.*
import io.github.fantasylum.rgbot.resid.*
import io.github.fantasylum.rgbot.screens.GameScreen
import io.github.fantasylum.rgbot.util.GameScreenAssets

abstract class Bot(velocity: Float = DEFAULT_HORIZONTAL_VELOCITY,
                   private val nextColor: (Color) -> Color = defaultNextColor): Actor() {
    private val textures = mapOf(RED   to GameScreenAssets.getAnimation(Animations.BOT_RED),
                                 GREEN to GameScreenAssets.getAnimation(Animations.BOT_GREEN),
                                 BLUE  to GameScreenAssets.getAnimation(Animations.BOT_BLUE))
    var color = GREEN
        private set

    private val fireEffect      = mapOf(RED to ParticleEffect(GameScreenAssets.fireAnimationRED),
                                        GREEN to ParticleEffect(GameScreenAssets.fireAnimationGREEN),
                                        BLUE to ParticleEffect(GameScreenAssets.fireAnimationBLUE))

    private val explosionEffect = ParticleEffect(GameScreenAssets.explosionAnimation)
    private var timeAlive       = 0f
    protected val velocity      = Vector2(velocity, 0f)
    protected var alive         = true
    private var destroyed       = false

    private var delta = 0f

    init {
        width   = WIDTH
        height  = HEIGHT

        assert(textures.values
                       .flatMap { it.keyFrames.asIterable() }
                       .all { it.regionWidth == width.toInt() && it.regionHeight == height.toInt() } )
    }

    override fun act(delta: Float) {
        timeAlive += delta

        if (alive) {
            x += velocity.x * delta
            y += velocity.y * delta
        }

        this.delta = delta

        if (y < 0 || y > GameScreen.WORLD_HEIGHT)
            this.destroy()
    }

    override fun draw(batch: Batch, parentAlpha: Float) {
        if (alive) {
            val texture = textures[color]!!.getKeyFrame(timeAlive, true)
            fireEffect[color]!!.setPosition(x + width / 2, y + height / 5)
            fireEffect[color]!!.draw(batch, delta)
            batch.draw(texture, x, y, width, height)
        } else {
            if (!explosionEffect.isComplete) {
                explosionEffect.draw(batch, delta)
            } else {
                destroyed = true
            }
        }
    }

    fun changeColor() {
        color = nextColor(color)
    }

    fun destroy() {
        if (alive) {
            alive = false
            explosionEffect.setPosition(x + width / 2, y + height / 2)
            explosionEffect.start()
        }
    }

    companion object {
        val defaultNextColor: (Color) -> Color = { Color.values()[(it.ordinal + 1) % Color.values().size] }

        val WIDTH = 30f
        val HEIGHT = 30f

        internal const val DEFAULT_HORIZONTAL_VELOCITY = 120f

    }

    fun isAlive() : Boolean {
        return alive
    }
}