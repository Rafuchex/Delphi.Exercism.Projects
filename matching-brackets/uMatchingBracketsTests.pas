unit uMatchingBracketsTests;

interface
uses
  DUnitX.TestFramework;

const
  CanonicalVersion = '2.0.0.1';

type
  [TestFixture]
  TMatchingBracketTest = class(TObject)
  public
    [Test]
//    [Ignore('Comment the "[Ignore]" statement to run the test')]
    procedure paired_square_brackets;

    [Test]
    procedure empty_string;

    [Test]
    procedure unpaired_brackets;

    [Test]
    procedure wrong_ordered_brackets;

    [Test]
    procedure wrong_closing_bracket;

    [Test]
    procedure paired_with_whitespace;

    [Test]
    procedure partially_paired_brackets;

    [Test]
    procedure simple_nested_brackets;

    [Test]
    procedure several_paired_brackets;

    [Test]
    procedure paired_and_nested_brackets;

    [Test]
    procedure unopened_closing_brackets;

    [Test]
    procedure unpaired_and_nested_brackets;

    [Test]
    procedure paired_and_wrong_nested_brackets;

    [Test]
    procedure paired_and_incomplete_brackets;

    [Test]
    procedure too_many_closing_brackets;

    [Test]
    procedure math_expression;

    [Test]
    procedure complex_latex_expression;
  end;

implementation
uses uMatchingBrackets;


{ TMatchingBracketTest }

procedure TMatchingBracketTest.complex_latex_expression;
begin
  Assert.IsTrue(TMatchingBrackets.IsPaired(
    '\\left(\\begin{array}{cc} \\frac{1}{3} & x\\\\ \\mathrm{e}^{x} &... x^2 \\end{array}\\right)'));
end;

procedure TMatchingBracketTest.empty_string;
begin
  Assert.IsTrue(TMatchingBrackets.IsPaired(''));
end;

procedure TMatchingBracketTest.math_expression;
begin
  Assert.IsTrue(TMatchingBrackets.IsPaired('(((185 + 223.85) * 15) - 543)/2'));
end;

procedure TMatchingBracketTest.paired_and_incomplete_brackets;
begin
  Assert.IsFalse(TMatchingBrackets.IsPaired('{}['));
end;

procedure TMatchingBracketTest.paired_and_nested_brackets;
begin
  Assert.IsTrue(TMatchingBrackets.IsPaired('([{}({}[])])'));
end;

procedure TMatchingBracketTest.paired_and_wrong_nested_brackets;
begin
  Assert.IsFalse(TMatchingBrackets.IsPaired('[({]})'));
end;

procedure TMatchingBracketTest.paired_square_brackets;
begin
  Assert.IsTrue(TMatchingBrackets.IsPaired('[]'));
end;

procedure TMatchingBracketTest.paired_with_whitespace;
begin
  Assert.IsTrue(TMatchingBrackets.IsPaired('{ }'));
end;

procedure TMatchingBracketTest.partially_paired_brackets;
begin
  Assert.IsFalse(TMatchingBrackets.IsPaired('{[])'));
end;

procedure TMatchingBracketTest.several_paired_brackets;
begin
  Assert.IsTrue(TMatchingBrackets.IsPaired('{}[]'));
end;

procedure TMatchingBracketTest.simple_nested_brackets;
begin
  Assert.IsTrue(TMatchingBrackets.IsPaired('{[]}'));
end;

procedure TMatchingBracketTest.too_many_closing_brackets;
begin
  Assert.IsFalse(TMatchingBrackets.IsPaired('[]]'));
end;

procedure TMatchingBracketTest.unopened_closing_brackets;
begin
  Assert.IsFalse(TMatchingBrackets.IsPaired('{[)][]}'));
end;

procedure TMatchingBracketTest.unpaired_and_nested_brackets;
begin
  Assert.IsFalse(TMatchingBrackets.IsPaired('([{])'));
end;

procedure TMatchingBracketTest.unpaired_brackets;
begin
  Assert.IsFalse(TMatchingBrackets.IsPaired('[['));
end;

procedure TMatchingBracketTest.wrong_closing_bracket;
begin
  Assert.IsFalse(TMatchingBrackets.IsPaired('{]'));
end;

procedure TMatchingBracketTest.wrong_ordered_brackets;
begin
  Assert.IsFalse(TMatchingBrackets.IsPaired('}{'));
end;

initialization
  TDUnitX.RegisterTestFixture(TMatchingBracketTest);
end.
