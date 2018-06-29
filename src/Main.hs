{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE EmptyDataDecls       #-}
{-# LANGUAGE FlexibleContexts     #-}
{-# LANGUAGE FlexibleInstances    #-}
{-# LANGUAGE GADTs                #-}
{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE QuasiQuotes          #-}
{-# LANGUAGE TemplateHaskell      #-}
{-# LANGUAGE TypeFamilies         #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
{-# LANGUAGE MultiParamTypeClasses #-}
module Main where
import Data.Text.Lazy
import Data.Monoid ((<>))
import Web.Scotty
import qualified Web.Scotty as S
import Database.Persist
import Database.Persist.Sqlite
import Database.Persist.TH 
import Data.Text (Text)
import Data.Time (UTCTime, getCurrentTime)
import qualified Data.Text as T
import Control.Monad.IO.Class (liftIO)
import Control.Monad.Trans.Resource (runResourceT, ResourceT)
import Database.Persist.Sql
import Control.Monad (forM_)
import Control.Applicative
import Control.Monad.Logger
import Data.Aeson 
import Data.Default.Class
import GHC.Generics
import Control.Monad.IO.Class (liftIO)

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
ToDo
  title String
  description String
  deriving Show
|]


runDb :: SqlPersist (ResourceT (NoLoggingT IO)) a -> IO a
runDb = runNoLoggingT
	. runResourceT
	. withSqliteConn "todo.db"
	. runSqlConn


instance ToJSON ToDo where
  toJSON(ToDo title description) = object ["title" .= title, "description" .= description]



readToDo :: IO [Entity ToDo]
readToDo = (runDb $ selectList [] [LimitTo 10] )

routes :: ScottyM()
routes = do
  S.get "/hello" $ do
    text "hello world!"
  S.get "/hello/:name" $ do
    name <- param "name"
    text ("hello" <> name <> "!")
  S.get "/todos" $ do
    _ToDo <- liftIO readToDo 
    text(pack . show $ _ToDo)

main = do
  putStrLn "Starting server...."
  scotty 7777 routes
