module TidalProc where

  import Sound.Tidal.Stream
  import Sound.Tidal.Pattern
  import Sound.Tidal.Parse
  import Sound.Tidal.OscStream

  port = 5000

  procShape = Shape {
    params = [
      S "setting" Nothing,
      F "view" (Just 0),
      F "a" (Just 0),
      F "b" (Just 0),
      F "c" (Just 0),
      F "d" (Just 0),
      F "e" (Just 0),
      F "f" (Just 0),
      F "g" (Just 0),
      F "camx" (Just 0),
      F "camy" (Just 0),
      F "camz" (Just 0),
      F "reset" (Just 0)
    ],
    cpsStamp = True,
    latency = 0.1
  }

  procSlang = OscSlang {
    path = "/proc_osc",
    timestamp = NoStamp,
    namedParams = False,
    preamble = []
  }

  procStream = do
    s <- makeConnection "127.0.0.1" port procSlang
    stream (Backend s $ (\_ _ _ -> return ())) procShape

  setting = makeS procShape "setting"
  view = makeF procShape "view"
  a = makeF procShape "a"
  b = makeF procShape "b"
  c = makeF procShape "c"
  d = makeF procShape "d"
  e = makeF procShape "e"
  f = makeF procShape "f"
  g = makeF procShape "g"
  camx = makeF procShape "camx"
  camy = makeF procShape "camy"
  camz = makeF procShape "camz"
  reset = makeF procShape "reset"
