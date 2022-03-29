module Date

public export
data LengthStyle
  = Long
  | Short

public export
record DateFormat where
  constructor MkDateFormat
  dateStyle : LengthStyle
  timeStyle : LengthStyle

public export
Show DateFormat where
  show (MkDateFormat Long Long) = "MMM d yyyy HH:mm"
  show (MkDateFormat Short Long) = ?ddd_4
  show (MkDateFormat Long Short) = "yyyy/MM/dd"
  show (MkDateFormat Short Short) = ?ddd_6

public export
data StringFormat : String -> Type where
  ShortFmt : StringFormat "yyyy/MM/dd"
  LongFmt : StringFormat "MMM d yyyy HH:mm"

||| Convert a the date format as a string into a date format object
public export
formatString : (0 str : String) -> {auto isValidFomat : StringFormat str} -> DateFormat
formatString _ {isValidFomat = ShortFmt} = MkDateFormat Long Short
formatString _ {isValidFomat = LongFmt} = MkDateFormat Long Short

public export
Date : Type
Date = Int

public export
renderDate : Date -> DateFormat -> String

