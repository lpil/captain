{-# LANGUAGE OverloadedStrings #-}

module WebSpec where

import Captain (appWith)
import Support (testAppConfig)
import Test.Hspec
import Test.Hspec.Runner (configFastFail, defaultConfig, hspecWith)
import Test.Hspec.Wai
import Web.Spock (spockAsApp)

main :: IO ()
main = hspecWith defaultConfig {configFastFail = True} spec

spec :: Spec
spec =
  with (spockAsApp $ appWith testAppConfig) $
  describe "GET /" $
  it "serves the home page" $ do
    let resp = get "/"
    resp `shouldRespondWith` 200
    resp `shouldRespondWith` "Hello, Sailor!"
