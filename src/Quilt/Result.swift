// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


public enum Result<T, U> {
  case ok(T)
  case alt(U)
}
