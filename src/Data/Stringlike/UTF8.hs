{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeSynonymInstances #-}

module Data.Stringlike.UTF8 (convert) where

import qualified Data.ByteString as BS
import qualified Data.ByteString.Lazy as BS.L
import qualified Data.Text as Tx
import qualified Data.Text.Encoding as Tx.E
import qualified Data.Text.Lazy as Tx.L

convert :: (Stringlike a, Stringlike b) => a -> b
convert = fromText . toText

class Stringlike s where
  toText :: s -> Tx.Text
  fromText :: Tx.Text -> s

instance Stringlike String where
  toText = Tx.pack
  fromText = Tx.unpack

instance Stringlike BS.ByteString where
  toText = Tx.E.decodeUtf8
  fromText = Tx.E.encodeUtf8

instance Stringlike BS.L.ByteString where
  toText = Tx.E.decodeUtf8 . BS.L.toStrict
  fromText = BS.L.fromStrict . Tx.E.encodeUtf8

instance Stringlike Tx.Text where
  toText = id
  fromText = id

instance Stringlike Tx.L.Text where
  toText = Tx.L.toStrict
  fromText = Tx.L.fromStrict
