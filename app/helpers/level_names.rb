module LevelNames
  PREFIX = '/levels/'

  LEVEL_PATHS = [
    PREFIX + "one",
    PREFIX + "2",
    PREFIX + "iii",
    PREFIX + "quatro",
    PREFIX + "onwards",
    PREFIX + "00000110"
  ]

  LEVEL_3_SECRET = "HellaTameableTransferProtocol"

  def level_path(level_num)
    LEVEL_PATHS[level_num-1]
  end

end

# not actually a helpers do