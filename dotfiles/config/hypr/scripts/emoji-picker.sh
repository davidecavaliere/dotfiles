#!/usr/bin/env bash

emojis=$(cat <<'EOF'
😀 grinning
😂 joy
🤣 rolling
😅 sweat smile
😊 blush
😍 heart eyes
🤔 thinking
😎 cool
🥺 pleading
🤗 hugging
😴 sleeping
🤯 mind blown
🥳 party
😭 cry
🤬 cursing
👍 thumbs up
👎 thumbs down
👏 clap
🙌 raised hands
🤝 handshake
💪 muscle
🙏 pray/fold
🔥 fire
⭐ star
✨ sparkles
🚀 rocket
🎉 party popper
💡 idea
🧠 brain
🎯 bullseye
💯 100
✅ check
❌ cross
⚠️ warning
🛑 stop
❤️ heart
🧡 orange heart
💛 yellow
💚 green
💙 blue
💜 purple
🖤 black
🤍 white
🤎 brown
💔 broken heart
💕 two hearts
💖 sparkling heart
🫶 heart hands
🫡 salute
🫠 melting
🫥 dotted line face
🫢 open eyes
🫣 peeking
🫤 diagonal mouth
🫧 bubbles
🐛 bug
EOF
)

selected=$(echo "$emojis" | hyprlauncher -m | cut -d' ' -f1)
[[ -n "$selected" ]] && wl-copy "$selected"
