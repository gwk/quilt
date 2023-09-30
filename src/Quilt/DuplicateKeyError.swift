// Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.


public struct DuplicateKeyError<K, V>: Error {
  public let key: K
  public let existing: V
  public let incoming: V
}
