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
      F "va" (Just 0),
      F "vb" (Just 0),
      F "vc" (Just 0),
      F "vx" (Just 0),
      F "vy" (Just 0),
      F "vz" (Just 0)
    ],
    cpsStamp = True,
    latency = 0.38
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
  va = makeF procShape "va"
  vb = makeF procShape "vb"
  vc = makeF procShape "vc"
  vx = makeF procShape "vx"
  vy = makeF procShape "vy"
  vz = makeF procShape "vz"
