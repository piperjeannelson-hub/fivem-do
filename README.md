## FiveM /do Command

A QBCore-compatible command that creates floating text at a player's ped waist line.

### Features
- Create floating roleplay text with `/do [text]`
- Remove the text with `/removedo`
- Text appears at the ped's waist bone
- Automatically scales based on camera distance
- White text with drop shadow and outline for visibility
- Networked so other players can see it

### Installation

1. Place this folder in your `resources` directory
2. Add to your `server.cfg`:
```
ensure fivem-do
```

### Usage

**Create floating text:**
```
/do Your text here
```

**Remove floating text:**
```
/removedo
```

### Requirements
- QBCore
- FiveM

### Files
- `fxmanifest.lua` - Resource manifest
- `client.lua` - Client-side script (displays the floating text)
- `server.lua` - Server-side script (command registration)
- `README.md` - This file
