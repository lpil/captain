{-# LANGUAGE OverloadedStrings #-}

module WebSpec where

import Captain (appWith)
import Support (bodyContains, testAppConfig)
import Test.Hspec
import Test.Hspec.Runner (configFastFail, defaultConfig, hspecWith)
import Test.Hspec.Wai
import Test.Hspec.Wai.Matcher
import Web.Spock (spockAsApp)

main :: IO ()
main = hspecWith defaultConfig {configFastFail = True} spec

spec :: Spec
spec =
  with (spockAsApp $ appWith testAppConfig) $
  describe "GET /" $
  it "serves the home page" $
  get "/" `shouldRespondWith` 200 {matchBody = bodyContains "Hello, Sailor!"}
