//=============================================================================
// You are expected to write an abstraction layer for your class called
// IPhoneNumber.  Your unit 'uPhoneNumber.pas' should only expose the
// abstraction layer along with a function called 'NewPhoneNumber' that returns
// an instance of IPhoneNumber.
//=============================================================================
unit uPhoneNumberTests;

interface
uses
  DUnitX.TestFramework;

const
  CanonicalVersion = '1.7.0';

type

  [TestFixture]
  PhoneNumberTests = class(TObject)
  public
    [Test]
//    [Ignore('Comment the "[Ignore]" statement to run the test')]
    procedure Cleans_the_number;

    [Test]
    procedure Cleans_numbers_with_dots;

    [Test]
    procedure Cleans_numbers_with_multiple_spaces;

    [Test]
    procedure Invalid_when_9_digits;

    [Test]
    procedure Invalid_when_11_digits_does_not_start_with_a_1;

    [Test]
    procedure Valid_when_11_digits_and_starting_with_1;

    [Test]
    procedure Valid_when_11_digits_and_starting_with_1_even_with_punctuation;

    [Test]
    procedure Invalid_when_more_than_11_digits;

    [Test]
    procedure Invalid_with_letters;

    [Test]
    procedure Invalid_with_punctuations;

    [Test]
    procedure Invalid_if_area_code_starts_with_0;

    [Test]
    procedure Invalid_if_area_code_starts_with_1;

    [Test]
    procedure Invalid_if_exchange_code_starts_with_0;

    [Test]
    procedure Invalid_if_exchange_code_starts_with_1;

    [Test]
    procedure Invalid_if_area_code_starts_with_0_on_valid_11_digit_number;

    [Test]
    procedure Invalid_if_area_code_starts_with_1_on_valid_11_digit_number;

    [Test]
    procedure Invalid_if_exchange_code_starts_with_0_on_valid_11_digit_number;

    [Test]
    procedure Invalid_if_exchange_code_starts_with_1_on_valid_11_digit_number;

    [Test]
    procedure Extract_area_code;

    [Test]
    procedure Extract_exchange_code;

    [Test]
    procedure Formats_a_number;
  end;

implementation
uses uPhoneNumber;

procedure PhoneNumberTests.Cleans_the_number;
var phone: IPhoneNumber;
begin
  phone := NewPhoneNumber('(223) 456-7890');
  assert.AreEqual('2234567890',phone.Clean);
end;

procedure PhoneNumberTests.Cleans_numbers_with_dots;
var phone: IPhoneNumber;
begin
  phone := NewPhoneNumber('223.456.7890');
  assert.AreEqual('2234567890',phone.Clean);
end;

procedure PhoneNumberTests.Cleans_numbers_with_multiple_spaces;
var phone: IPhoneNumber;
begin
  phone := NewPhoneNumber('223 456   7890   ');
  assert.AreEqual('2234567890',phone.Clean);
end;

procedure PhoneNumberTests.Valid_when_11_digits_and_starting_with_1;
var phone: IPhoneNumber;
begin
  phone := NewPhoneNumber('12234567890');
  assert.AreEqual('2234567890', phone.Clean);
end;

procedure PhoneNumberTests.Valid_when_11_digits_and_starting_with_1_even_with_punctuation;
var phone: IPhoneNumber;
begin
  phone := NewPhoneNumber('+1 (223) 456-7890');
  assert.AreEqual('2234567890', phone.Clean);
end;

procedure PhoneNumberTests.Invalid_when_11_digits_does_not_start_with_a_1;
var phone: IPhoneNumber;
begin
  phone := NewPhoneNumber('22234567890');
  assert.AreEqual('', phone.Clean);
end;

procedure PhoneNumberTests.Invalid_when_more_than_11_digits;
var phone: IPhoneNumber;
begin
  phone := NewPhoneNumber('321234567890');
  assert.AreEqual('', phone.Clean);
end;

procedure PhoneNumberTests.Invalid_when_9_digits;
var phone: IPhoneNumber;
begin
  phone := NewPhoneNumber('123456789');
  assert.AreEqual('', phone.Clean);
end;

procedure PhoneNumberTests.Invalid_with_letters;
var phone: IPhoneNumber;
begin
  phone := NewPhoneNumber('123-abc-7890');
  assert.AreEqual('', phone.Clean);
end;

procedure PhoneNumberTests.Invalid_with_punctuations;
var phone: IPhoneNumber;
begin
  phone := NewPhoneNumber('123-@:!-7890');
  assert.AreEqual('', phone.Clean);
end;

procedure PhoneNumberTests.Invalid_if_area_code_starts_with_0;
var phone: IPhoneNumber;
begin
  phone := NewPhoneNumber('(023) 456-7890');
  assert.AreEqual('', phone.Clean);
end;

procedure PhoneNumberTests.Invalid_if_area_code_starts_with_0_on_valid_11_digit_number;
var phone: IPhoneNumber;
begin
  phone := NewPhoneNumber('1 (023) 456-7890');
  assert.AreEqual('', phone.Clean);
end;

procedure PhoneNumberTests.Invalid_if_area_code_starts_with_1;
var phone: IPhoneNumber;
begin
  phone := NewPhoneNumber('(123) 456-7890');
  assert.AreEqual('', phone.Clean);
end;

procedure PhoneNumberTests.Invalid_if_area_code_starts_with_1_on_valid_11_digit_number;
var phone: IPhoneNumber;
begin
  phone := NewPhoneNumber('1 (123) 456-7890');
  assert.AreEqual('', phone.Clean);
end;

procedure PhoneNumberTests.Invalid_if_exchange_code_starts_with_0;
var phone: IPhoneNumber;
begin
  phone := NewPhoneNumber('(223) 056-7890');
  assert.AreEqual('', phone.Clean);
end;

procedure PhoneNumberTests.Invalid_if_exchange_code_starts_with_0_on_valid_11_digit_number;
var phone: IPhoneNumber;
begin
  phone := NewPhoneNumber('1 (223) 056-7890');
  assert.AreEqual('', phone.Clean);
end;

procedure PhoneNumberTests.Invalid_if_exchange_code_starts_with_1;
var phone: IPhoneNumber;
begin
  phone := NewPhoneNumber('(223) 156-7890');
  assert.AreEqual('', phone.Clean);
end;

procedure PhoneNumberTests.Invalid_if_exchange_code_starts_with_1_on_valid_11_digit_number;
var phone: IPhoneNumber;
begin
  phone := NewPhoneNumber('1 (223) 156-7890');
  assert.AreEqual('', phone.Clean);
end;

procedure PhoneNumberTests.Extract_area_code;
var phone: IPhoneNumber;
begin
  phone := NewPhoneNumber('(223) 456-7890');
  assert.AreEqual('223', phone.Area);
end;

procedure PhoneNumberTests.Extract_exchange_code;
var phone: IPhoneNumber;
begin
  phone := NewPhoneNumber('223.456.7890');
  assert.AreEqual('456', phone.Exchange);
end;

procedure PhoneNumberTests.Formats_a_number;
var phone: IPhoneNumber;
begin
  phone := NewPhoneNumber('2234567890');
  assert.AreEqual('(223) 456-7890', phone.ToString);
end;

initialization
  TDUnitX.RegisterTestFixture(PhoneNumberTests);
end.
