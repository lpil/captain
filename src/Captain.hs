{-# LANGUAGE OverloadedStrings #-}

module Captain
  ( app
  ) where

import Web.Spock

app :: SpockM () () () ()
app = do
  get root $ text "Hello World!"
  get "about" $ text "About!"
