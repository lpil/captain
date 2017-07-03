module Support
  ( testAppConfig
  , bodyContains
  ) where

import Captain (AppConfig(..))
import Data.ByteString (isInfixOf)
import Data.ByteString.Lazy (toStrict)
import Test.Hspec.Wai.Matcher (Body, MatchBody(..))

testAppConfig :: AppConfig
testAppConfig = AppConfig {useLogger = False}

{-| Check whether a response body contains a given substring.
-}
bodyContains :: Body -> MatchBody
bodyContains subString = MatchBody bodyContains'
  where
    bodyContains' _ body =
      if toStrict subString `isInfixOf` toStrict body
        then Nothing
        else Just $ errorMsg body
    errorMsg body =
      unlines
        ["Body did not contain `" ++ show subString ++ "`", "Body:", show body]
