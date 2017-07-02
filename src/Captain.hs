{-# LANGUAGE OverloadedStrings #-}

module Captain
  ( main
  , app
  ) where

import Web.Spock
import Web.Spock.Config

main :: IO ()
main = do
  spockCfg <- defaultSpockCfg () PCNoDatabase ()
  runSpock 4000 (spock spockCfg app)

app :: SpockM () () () ()
app = do
  get root $ text "Hello, Sailor!"
  get "about" $ text "About!"
