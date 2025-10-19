unit uAllergiesTests;

interface
uses
  DUnitX.TestFramework, System.Generics.Collections;

const
  CanonicalVersion = '2.0.0';

type
  [TestFixture('testing for eggs allergy')]
  TEggAllergy = class(TObject)
    [Test]
//    [Ignore('Comment the "[Ignore]" statement to run the test')]
    procedure NotAllergicToAnything;

    [Test]
    procedure AllergicOnlyToEggs;

    [Test]
    procedure AllergicToEggsAndSomethingElse;

    [Test]
    procedure AllergicToSomethingButNotEggs;

    [Test]
    procedure AllergicToEverything;
  end;

  [TestFixture('testing for peanuts allergy')]
  TPeanutAllergy = class(TObject)
    [Test]
    procedure NotAllergicToAnything;

    [Test]
    procedure AllergicOnlyToPeanuts;

    [Test]
    procedure AllergicToPeanutsAndSomethingElse;

    [Test]
    procedure AllergicToSomethingButNotPeanuts;

    [Test]
    procedure AllergicToEverything;
  end;

  [TestFixture('testing for shellfish allergy')]
  TShellfishAllergy = class(TObject)
    [Test]
    procedure NotAllergicToAnything;

    [Test]
    procedure AllergicOnlyToShellfish;

    [Test]
    procedure AllergicToShellfishAndSomethingElse;

    [Test]
    procedure AllergicToSomethingButNotShellfish;

    [Test]
    procedure AllergicToEverything;
  end;

  [TestFixture('testing for strawberries allergy')]
  TStrawberryAllergy = class(TObject)
    [Test]
    procedure NotAllergicToAnything;

    [Test]
    procedure AllergicOnlyToStrawberries;

    [Test]
    procedure AllergicToStrawberriesAndSomethingElse;

    [Test]
    procedure AllergicToSomethingButNotStrawberries;

    [Test]
    procedure AllergicToEverything;
  end;

  [TestFixture('testing for tomatoes allergy')]
  TTomatoesAllergy = class(TObject)
    [Test]
    procedure NotAllergicToAnything;

    [Test]
    procedure AllergicOnlyToTomatoes;

    [Test]
    procedure AllergicToTomatoesAndSomethingElse;

    [Test]
    procedure AllergicToSomethingButNotTomatoes;

    [Test]
    procedure AllergicToEverything;
  end;

  [TestFixture('testing for chocolate allergy')]
  TChocolateAllergy = class(TObject)
    [Test]
    procedure NotAllergicToAnything;

    [Test]
    procedure AllergicOnlyToChocolate;

    [Test]
    procedure AllergicToChocolateAndSomethingElse;

    [Test]
    procedure AllergicToSomethingButNotChocolate;

    [Test]
    procedure AllergicToEverything;
  end;

  [TestFixture('testing for pollen allergy')]
  TPollenAllergy = class(TObject)
    [Test]
    procedure NotAllergicToAnything;

    [Test]
    procedure AllergicOnlyToPollen;

    [Test]
    procedure AllergicToPollenAndSomethingElse;

    [Test]
    procedure AllergicToSomethingButNotPollen;

    [Test]
    procedure AllergicToEverything;
  end;

  [TestFixture('testing for cats allergy')]
  TCatAllergy = class(TObject)
    [Test]
    procedure NotAllergicToAnything;

    [Test]
    procedure AllergicOnlyToCats;

    [Test]
    procedure AllergicToCatsAndSomethingElse;

    [Test]
    procedure AllergicToSomethingButNotCats;

    [Test]
    procedure AllergicToEverything;
  end;

  [TestFixture('list when:')]
  TTomsAllergies = class(TObject)
  private
    expected: TList<string>;
  public
    [Setup]
    procedure Setup;

    [TearDown]
    procedure TearDown;

    [Test]
    procedure NoAllergies;

    [Test]
    procedure JustEggs;

    [Test]
    procedure JustPeanuts;

    [Test]
    procedure JustStrawberries;

    [Test]
    procedure EggsAndPeanuts;

    [Test]
    procedure MoreThanEggsButNotPeanuts;

    [Test]
    procedure LotsOfStuff;

    [Test]
    procedure Everything;

    [Test]
    procedure NoAllergenScoreParts;
  end;

implementation

uses uAllergies;

type
  Assert = class(DUnitX.TestFramework.Assert)
    class procedure AreEqual(expected, actual: TList<string>); overload;
  end;

{ Assert }

class procedure Assert.AreEqual(expected, actual: TList<string>);
var i: integer;
begin
  Assert.AreEqual(expected.Count, actual.Count);
  expected.Sort;
  actual.Sort;
  for i := 0 to expected.Count - 1 do
    Assert.AreEqual(expected[i], actual[i]);
end;

{ TEggAllergy }

procedure TEggAllergy.AllergicOnlyToEggs;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(1);
  assert.IsTrue(allergies.AllergicTo('eggs'));
end;

procedure TEggAllergy.AllergicToEggsAndSomethingElse;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(3);
  assert.IsTrue(allergies.AllergicTo('eggs'));
end;

procedure TEggAllergy.AllergicToEverything;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(255);
  assert.IsTrue(allergies.AllergicTo('eggs'));
end;

procedure TEggAllergy.AllergicToSomethingButNotEggs;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(2);
  assert.IsFalse(allergies.AllergicTo('eggs'));
end;

procedure TEggAllergy.NotAllergicToAnything;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(0);
  assert.IsFalse(allergies.AllergicTo('eggs'));
end;

{ TPeanutAllergy }

procedure TPeanutAllergy.AllergicOnlyToPeanuts;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(2);
  assert.IsTrue(allergies.AllergicTo('peanuts'));
end;

procedure TPeanutAllergy.AllergicToEverything;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(255);
  assert.IsTrue(allergies.AllergicTo('peanuts'));
end;

procedure TPeanutAllergy.AllergicToPeanutsAndSomethingElse;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(7);
  assert.IsTrue(allergies.AllergicTo('peanuts'));
end;

procedure TPeanutAllergy.AllergicToSomethingButNotPeanuts;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(5);
  assert.IsFalse(allergies.AllergicTo('peanuts'));
end;

procedure TPeanutAllergy.NotAllergicToAnything;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(0);
  assert.IsFalse(allergies.AllergicTo('peanuts'));
end;

{ TShellfishAllergy }

procedure TShellfishAllergy.AllergicOnlyToShellfish;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(4);
  assert.IsTrue(allergies.AllergicTo('shellfish'));
end;

procedure TShellfishAllergy.AllergicToEverything;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(255);
  assert.IsTrue(allergies.AllergicTo('shellfish'));
end;

procedure TShellfishAllergy.AllergicToShellfishAndSomethingElse;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(14);
  assert.IsTrue(allergies.AllergicTo('shellfish'));
end;

procedure TShellfishAllergy.AllergicToSomethingButNotShellfish;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(10);
  assert.IsFalse(allergies.AllergicTo('shellfish'));
end;

procedure TShellfishAllergy.NotAllergicToAnything;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(0);
  assert.IsFalse(allergies.AllergicTo('shellfish'));
end;

{ TStrawberryAllergy }

procedure TStrawberryAllergy.AllergicOnlyToStrawberries;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(8);
  assert.IsTrue(allergies.AllergicTo('strawberries'));
end;

procedure TStrawberryAllergy.AllergicToEverything;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(255);
  assert.IsTrue(allergies.AllergicTo('strawberries'));
end;

procedure TStrawberryAllergy.AllergicToSomethingButNotStrawberries;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(20);
  assert.IsFalse(allergies.AllergicTo('strawberries'));
end;

procedure TStrawberryAllergy.AllergicToStrawberriesAndSomethingElse;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(28);
  assert.IsTrue(allergies.AllergicTo('strawberries'));
end;

procedure TStrawberryAllergy.NotAllergicToAnything;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(0);
  assert.IsFalse(allergies.AllergicTo('strawberries'));
end;

{ TTomatoesAllergy }

procedure TTomatoesAllergy.AllergicOnlyToTomatoes;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(16);
  assert.IsTrue(allergies.AllergicTo('tomatoes'));
end;

procedure TTomatoesAllergy.AllergicToEverything;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(255);
  assert.IsTrue(allergies.AllergicTo('tomatoes'));
end;

procedure TTomatoesAllergy.AllergicToSomethingButNotTomatoes;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(40);
  assert.IsFalse(allergies.AllergicTo('tomatoes'));
end;

procedure TTomatoesAllergy.AllergicToTomatoesAndSomethingElse;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(56);
  assert.IsTrue(allergies.AllergicTo('tomatoes'));
end;

procedure TTomatoesAllergy.NotAllergicToAnything;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(0);
  assert.IsFalse(allergies.AllergicTo('tomatoes'));
end;

{ TChocolateAllergy }

procedure TChocolateAllergy.AllergicOnlyToChocolate;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(32);
  assert.IsTrue(allergies.AllergicTo('chocolate'));
end;

procedure TChocolateAllergy.AllergicToChocolateAndSomethingElse;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(112);
  assert.IsTrue(allergies.AllergicTo('chocolate'));
end;

procedure TChocolateAllergy.AllergicToEverything;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(255);
  assert.IsTrue(allergies.AllergicTo('chocolate'));
end;

procedure TChocolateAllergy.AllergicToSomethingButNotChocolate;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(80);
  assert.IsFalse(allergies.AllergicTo('chocolate'));
end;

procedure TChocolateAllergy.NotAllergicToAnything;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(0);
  assert.IsFalse(allergies.AllergicTo('chocolate'));
end;

{ TPollenAllergy }

procedure TPollenAllergy.AllergicOnlyToPollen;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(64);
  assert.IsTrue(allergies.AllergicTo('pollen'));
end;

procedure TPollenAllergy.AllergicToEverything;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(255);
  assert.IsTrue(allergies.AllergicTo('pollen'));
end;

procedure TPollenAllergy.AllergicToPollenAndSomethingElse;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(224);
  assert.IsTrue(allergies.AllergicTo('pollen'));
end;

procedure TPollenAllergy.AllergicToSomethingButNotPollen;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(160);
  assert.IsFalse(allergies.AllergicTo('pollen'));
end;

procedure TPollenAllergy.NotAllergicToAnything;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(0);
  assert.IsFalse(allergies.AllergicTo('pollen'));
end;

{ TCatAllergy }

procedure TCatAllergy.AllergicOnlyToCats;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(128);
  assert.IsTrue(allergies.AllergicTo('cats'));
end;

procedure TCatAllergy.AllergicToCatsAndSomethingElse;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(192);
  assert.IsTrue(allergies.AllergicTo('cats'));
end;

procedure TCatAllergy.AllergicToEverything;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(255);
  assert.IsTrue(allergies.AllergicTo('cats'));
end;

procedure TCatAllergy.AllergicToSomethingButNotCats;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(64);
  assert.IsFalse(allergies.AllergicTo('cats'));
end;

procedure TCatAllergy.NotAllergicToAnything;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(0);
  assert.IsFalse(allergies.AllergicTo('cats'));
end;

{ TTomsAllergies }

procedure TTomsAllergies.EggsAndPeanuts;
var allergies: IAllergies;
begin
  expected.AddRange(['eggs', 'peanuts']);

  allergies := TAllergies.Create(3);
  Assert.AreEqual(expected, allergies.List);
end;

procedure TTomsAllergies.Everything;
var allergies: IAllergies;
begin
  expected.AddRange(['eggs',
                     'peanuts',
                     'shellfish',
                     'strawberries',
                     'tomatoes',
                     'chocolate',
                     'pollen',
                     'cats']);

  allergies := TAllergies.Create(255);
  Assert.AreEqual(expected, allergies.List);
end;

procedure TTomsAllergies.JustEggs;
var allergies: IAllergies;
begin
  expected.AddRange(['eggs']);

  allergies := TAllergies.Create(1);
  Assert.AreEqual(expected, allergies.List);
end;

procedure TTomsAllergies.JustPeanuts;
var allergies: IAllergies;
begin
  expected.AddRange(['peanuts']);

  allergies := TAllergies.Create(2);
  Assert.AreEqual(expected, allergies.List);
end;

procedure TTomsAllergies.JustStrawberries;
var allergies: IAllergies;
begin
  expected.AddRange(['strawberries']);

  allergies := TAllergies.Create(8);
  Assert.AreEqual(expected, allergies.List);
end;

procedure TTomsAllergies.LotsOfStuff;
var allergies: IAllergies;
begin
  expected.AddRange(['strawberries',
                     'tomatoes',
                     'chocolate',
                     'pollen',
                     'cats']);

  allergies := TAllergies.Create(248);
  Assert.AreEqual(expected, allergies.List);
end;

procedure TTomsAllergies.MoreThanEggsButNotPeanuts;
var allergies: IAllergies;
begin
  expected.AddRange(['eggs',
                     'shellfish']);

  allergies := TAllergies.Create(5);
  Assert.AreEqual(expected, allergies.List);
end;

procedure TTomsAllergies.NoAllergenScoreParts;
var allergies: IAllergies;
begin
  expected.AddRange(['eggs',
                     'shellfish',
                     'strawberries',
                     'tomatoes',
                     'chocolate',
                     'pollen',
                     'cats']);

  allergies := TAllergies.Create(509);
  Assert.AreEqual(expected, allergies.List);
end;

procedure TTomsAllergies.NoAllergies;
var allergies: IAllergies;
begin
  allergies := TAllergies.Create(0);
  Assert.AreEqual(expected, allergies.List);
end;

procedure TTomsAllergies.Setup;
begin
  expected := TList<string>.Create;
end;

procedure TTomsAllergies.TearDown;
begin
  expected.DisposeOf;
end;

initialization
  TDUnitX.RegisterTestFixture(TEggAllergy);
  TDUnitX.RegisterTestFixture(TPeanutAllergy);
  TDUnitX.RegisterTestFixture(TShellfishAllergy);
  TDUnitX.RegisterTestFixture(TStrawberryAllergy);
  TDUnitX.RegisterTestFixture(TTomatoesAllergy);
  TDUnitX.RegisterTestFixture(TChocolateAllergy);
  TDUnitX.RegisterTestFixture(TPollenAllergy);
  TDUnitX.RegisterTestFixture(TCatAllergy);
  TDUnitX.RegisterTestFixture(TTomsAllergies);
end.
