[fisherman]: https://github.com/fisherman/fisherman

# [fisherman] brew tap

## Usage

```shell
brew tap fisherman/tap
```

Then choose to install:

* the lastest stable version of [fisherman]

  ```
  brew install fisherman
  ```

* or latest commits from the `master` branch

  ```
  brew install --HEAD fisherman
  ```

When you `brew update` this tap will be automatically updated, then you can upgrade fisherman as any other formula:

```shell
brew update
brew upgrade fisherman
```

## Maintaining

Update the two fields in [`fisherman.rb`](./fisherman.rb#L5-L6):

- `url` the version in `fisher.fish`
- `sha256` which can be obtained with `shasum -a 256 fisher.fish`
