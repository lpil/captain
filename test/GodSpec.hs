module GodSpec where

import Test.Hspec
import Test.Hspec.Runner (configFastFail, defaultConfig, hspecWith)

main :: IO ()
main = hspecWith defaultConfig {configFastFail = True} spec

spec :: Spec
spec =
  describe "the universe" $
  it "behaves the way we expect it to" $ do
    1 `shouldBe` 1
    2 `shouldBe` 2
