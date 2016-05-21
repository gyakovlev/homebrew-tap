[fisherman]: https://github.com/fisherman/fisherman
[homebrew]: https://github.com/Homebrew/brew


# [fisherman][] [homebrew][] tap


## Usage

First add the _tap_:

```shell
brew tap fisherman/tap
```

Then you can install

- lastest stable version of [fisherman] with

  ```shell
  brew install fisherman
  ```

- or the version from the fisherman's repo `master` branch with

  ```shell
  brew install --HEAD fisherman
  ```

When you do `brew update` this tap will be updated automatically, you don't need to do anything special. Upgrade fisherman as any other formula:

```shell
brew update
brew upgrade fisherman
```


## Maintaining the tap

All you need to do is just to change two fields in [`fisherman.rb`](./fisherman.rb#L5-L6):

- `url` referring to the latest stable version of the `fisher.fish` file
- `sha256` which you can get with running `shasum -a 256 fisher.fish` on that file
