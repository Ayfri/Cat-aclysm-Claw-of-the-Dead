# Cat'aclysm: Claw of the Dead

A Tower Defense game in zombie apocalypse theme.
You play with cats, and you have to defend your city from the zombie invasion using towers.

## Engine

The game is made with [Godot Engine](https://godotengine.org/) 4.0.0.

## GitHub

#### Commit :

type(scope): subject

type: type of commit
scope: the scope that is affected by this commit
subject: a short description of the commit, 20 words max

#### Types :

* ci : Modification of files and scripts related to continuous integration
* chore : Modification of the build system or development tools
* feat : New feature
* fix : Bug fix
* perf : Optimization of the code to improve performance
* refactor : Modification of the code without changing functionality

#### Examples :

```
feat(zombies): add new pigeon zombie
```

```
fix(towers): fix tower range upgrade not working
```

```
refactor(animations): use animation player instead of animation tree for zombies
```

## Project Files :

We are following the Godot conventions as presented [here](https://docs.godotengine.org/en/latest/tutorials/best_practices/index.html).
Use the built-in editor from Godot to code or use any JetBrains IDE to edit godot scripts but do not use any other IDE.

### Code Architecture :

```
/project.godot
/assets/fonts/**.ttf : fonts
/assets/localization/**.po : localization files
/assets/scripts/**.gd : scripts
/assets/musics/**.mp3 : musics
/assets/sounds/**.ogg : sounds
/assets/sprites/particles/**.png : particles
/assets/sprites/towers/**.png : tower sprites
/assets/sprites/zombies/**.png : zombie sprites
/assets/tilemaps/**.png : tilemaps
/scenes/main.tscn : main scene
/scenes/**.tscn : scenes
```

### Code Style :

* Everything is in english
* Use `snake_case` for files
* Use `PascalCase` for nodes
* Use `camelCase` for variables and functions
* Use `PascalCase` for classes, enums, constants and signals
* Name every node with its function on the parent node (or the object name if root)
* Type everything unless it's obvious (e.g. `var x: int = 1` is fine, but `var x = 1` is simpler)
* Keep lines relatively short (140 characters max)
* Use tabs for indentation

## Exporting

The game is automatically exported as a `.exe` at the end of every day that received a commit.
Other platforms are exported by the CI when a tag is pushed.

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

## Authors

* [@Ayfri](https://github.com/Ayfri) : Lead dev & project manager
* [@MateoPerrotNasi](https://github.com/MateoPerrotNasi) : Dev
* [@AlexandreRocchi](https://github.com/AlexandreRocchi) : Dev
* [@ThiboRodenburger](https://github.com/ThiboRodenburger) : Dev
* [@Vincent-1000](https://github.com/Vincent-1000) : Dev
* [@xhmyjae](https://github.com/xhmyjae) : Game Artist & Tester
* [@lunasphys](https://gihtub.com/lunasphys) : Game Artist
