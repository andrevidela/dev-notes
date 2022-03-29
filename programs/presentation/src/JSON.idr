module JSON

import Language.JSON
import Data.List

rawPlaylistJSON : String
rawPlaylistJSON =  """
  { "type": "playlist",
    "object" : [ { "filename" : "song1",
                   "artist" : "Jonny"},
                 { "filename" : "song2",
                   "artist" : "Jenna"}
               ]
  }
  """

rawMusicJSON : String
rawMusicJSON =  """
  { "type": "music",
    "object" : { "filename" : "the song"
               , "artist" : "Jimmy" }
  }
  """

playlistJSON : JSON
playlistJSON = JObject
    [("type", JString "playlist")
    ,("object", JArray
       [ JObject [("filename", JString "song1")
                 ,("artist", JString "Jonny")]
       , JObject [("filename", JString "song2")
                 ,("artist", JString "Jenna")]
       ] )]


musicJSON : JSON
musicJSON = JObject
    [ ("type", JString "music")
    , ("object", JObject
        [("filename", JString "the song")
        ,("artist", JString "Jimmy")])
    ]

record Music where
  constructor MkMusic
  filename : String
  artist : String

GetType : JSON -> Type
GetType (JObject (("type", JString "music") :: xs)) = Music
GetType (JObject (("type", JString "playlist") :: xs)) = List Music
GetType _ = Void

parseMusic : JSON -> Maybe Music
parseMusic (JObject [("filename", JString filename)
                    ,("artist", JString artist)]) = Just (MkMusic filename artist)
parseMusic _ = Nothing

parseListOf : (JSON -> Maybe a) -> JSON -> Maybe (List a)
parseListOf fn (JArray ls) = traverse fn ls
parseListOf fn _ = Nothing

parseData : (json : JSON) -> Maybe (GetType json)
parseData (JObject [("type", JString "music"), ("object", obj)])
  = parseMusic obj
parseData (JObject [("type", JString "playlist"), ("object", obj)])
  = parseListOf parseMusic obj
parseData _ = Nothing






readVec : IO (List String)


main : IO ()
main = do vec1 <- readVec
          vec2 <- readVec
          let (Yes bounds) = inBounds 0 vec1
            | No contra => printLn "not in bounds"
          let first = List.index 0 vec1
          ?program
