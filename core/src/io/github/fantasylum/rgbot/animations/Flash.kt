package io.github.fantasylum.rgbot.animations

import com.badlogic.gdx.graphics.g2d.Batch
import com.badlogic.gdx.graphics.g2d.TextureRegion
import io.github.fantasylum.rgbot.interfaces.Anim

class Flash(override val texture: TextureRegion,
            override val speed: Float,
            override val isLoop: Boolean,
            private val minAlpha : Float = 0.25f) : Anim {

    private var alpha = 1f
    private var increment = false
    private var waitFor1 = false

    var isStopped = false

    override fun draw(batch: Batch, x: Float, y: Float, width: Float, height: Float, delta: Float) {
        if (!isStopped) {
            if (alpha > 1f) alpha = 1f
            if (alpha < 0f) alpha = 0f
            batch.setColor(1.0f, 1.0f, 1.0f, alpha)
            batch.draw(texture, x, y, width, height)
            batch.setColor(1.0f, 1.0f, 1.0f, 1.0f)
            assertAlpha(delta)
        }
    }

    private fun assertAlpha(delta: Float) {
        if (!waitFor1) {
            if (alpha <= minAlpha) {
                increment = true
                waitFor1 = true
            }
        } else {
            if (alpha >= 1f) {
                increment = false
                waitFor1 = false
                if (!isLoop) {
                    isStopped = true
                }
            }
        }
        if (increment) {
            alpha += delta * speed
        } else {
            alpha -= delta * speed
        }
    }

}