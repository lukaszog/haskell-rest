{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_RESTAPI (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/mnt/c/Users/Lukasz/Studia/Haskell/RESTAPI/.stack-work/install/x86_64-linux/lts-11.15/8.2.2/bin"
libdir     = "/mnt/c/Users/Lukasz/Studia/Haskell/RESTAPI/.stack-work/install/x86_64-linux/lts-11.15/8.2.2/lib/x86_64-linux-ghc-8.2.2/RESTAPI-0.1.0.0-8SFn4RZOcpKJJvX8CwedwC-RESTAPI"
dynlibdir  = "/mnt/c/Users/Lukasz/Studia/Haskell/RESTAPI/.stack-work/install/x86_64-linux/lts-11.15/8.2.2/lib/x86_64-linux-ghc-8.2.2"
datadir    = "/mnt/c/Users/Lukasz/Studia/Haskell/RESTAPI/.stack-work/install/x86_64-linux/lts-11.15/8.2.2/share/x86_64-linux-ghc-8.2.2/RESTAPI-0.1.0.0"
libexecdir = "/mnt/c/Users/Lukasz/Studia/Haskell/RESTAPI/.stack-work/install/x86_64-linux/lts-11.15/8.2.2/libexec/x86_64-linux-ghc-8.2.2/RESTAPI-0.1.0.0"
sysconfdir = "/mnt/c/Users/Lukasz/Studia/Haskell/RESTAPI/.stack-work/install/x86_64-linux/lts-11.15/8.2.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "RESTAPI_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "RESTAPI_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "RESTAPI_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "RESTAPI_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "RESTAPI_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "RESTAPI_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
