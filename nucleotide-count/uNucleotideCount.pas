{**********************************************}
{                                              }
{  uNucleotideCount.pas                        }
{  Programmed by Rafael Perez Marin            }
{  2025-10-12                                  }
{                                              }
{**********************************************}

unit uNucleotideCount;

interface

uses System.SysUtils, System.Contnrs, System.Generics.Collections;

Type
  EInvalidNucleotideException = class (Exception)
  public
    Constructor Create (const msg: string);
  end;

  TDNA = class
  private
    FNucleotideCounts: TDictionary<char,integer>;
  public
    Constructor Create (Seq: string);
    Destructor Destroy; override;
    property NucleotideCounts: TDictionary<char,integer> read FNucleotideCounts;
  end;

implementation

Constructor EInvalidNucleotideException.Create (const msg: string);
Begin
  Inherited Create(msg);
End;

Constructor TDNA.Create (Seq: string);
var Ch: char;
Begin
  for Ch in Seq do
    if ((Ch <> 'A') and (Ch <> 'T') and (Ch <> 'C') and (Ch <> 'G')) then
      raise EInvalidNucleotideException.Create('Invalid nucleotide in strand');

  FNucleotideCounts := TDictionary<char,integer>.Create();
  FNucleotideCounts.Add('A',0);
  FNucleotideCounts.Add('T',0);
  FNucleotideCounts.Add('C',0);
  FNucleotideCounts.Add('G',0);

  for Ch in Seq do
    FNucleotideCounts[Ch] := FNucleotideCounts[Ch] + 1;
End;

Destructor TDNA.Destroy;
Begin
  FNucleotideCounts.Free;
  Inherited;
End;

end.
