unit uMainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls; {FileCtrl, Registry, IniFiles, DB, dbisamtb, entryprog,
  Grids, DBGrids, ClientServer, objDBDataItem, TypeDecsDB, objDBData;}

type
  TForm1 = class(TForm)
    btnShow: TButton;
    Panel1: TPanel;
    btnCreate: TButton;
    btnAddCity: TButton;
    Panel2: TPanel;
    Label1: TLabel;
    edtCityName: TEdit;
    rgCityTypes: TRadioGroup;
    rgAdminTypes: TRadioGroup;
    btnCreateCity: TButton;
    Panel3: TPanel;
    Label2: TLabel;
    edtCountyName: TEdit;
    btnCreateCounty: TButton;
    btnAddCounty: TButton;
    btnAddCountry: TButton;
    Panel4: TPanel;
    Label4: TLabel;
    edtStateName: TEdit;
    Label3: TLabel;
    edtCountryName: TEdit;
    btnCreateCountry: TButton;
    Panel5: TPanel;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    edtAddrNum: TEdit;
    edtAddrName: TEdit;
    edtAptNum: TEdit;
    btnAddAddress: TButton;
    btnCreateAddress: TButton;
    cbCities: TComboBox;
    Label7: TLabel;
    cbCounties: TComboBox;
    Label8: TLabel;
    cbStates: TComboBox;
    Label9: TLabel;
    cbCountries: TComboBox;
    Label10: TLabel;
    cbAddresses: TComboBox;
    Label11: TLabel;
    Label12: TLabel;
    edtAddrZip: TEdit;
    memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnShowClick(Sender: TObject);
    procedure rgCityTypesClick(Sender: TObject);
    procedure rgAdminTypesClick(Sender: TObject);
    procedure btnAddCityClick(Sender: TObject);
    procedure btnCreateCityClick(Sender: TObject);
    procedure btnAddCountyClick(Sender: TObject);
    procedure btnCreateCountyClick(Sender: TObject);
    procedure btnCreateCountryClick(Sender: TObject);
    procedure btnAddCountryClick(Sender: TObject);
    procedure btnAddAddressClick(Sender: TObject);
    procedure btnCreateAddressClick(Sender: TObject);
    procedure btnCreateClick(Sender: TObject);
  private
    //ADBData: TDBData;
  public
  end;

CityTypes = (Lost, Site, Community, Town, City);
  AdministrativeTypes = (None, Seat, Capital);

  TCity = packed class(TObject)
    protected
      name: String;
      type_: CityTypes;
      admin_type: AdministrativeTypes;
    public
      constructor Create(name: String; type_: CityTypes; admin_type: AdministrativeTypes); overload;
  end;

  TCounty = packed class(TObject)
    protected
      name: String;
      subdivisions: TList;
    private
      function getDesc: String;
    public
      constructor Create(name: String); overload;
      constructor Create(name: String; cities: TList); overload;
      procedure addCity(new_city: TCity);
    published
      property desc: String
        read getDesc;
  end;

  TState = packed class(TObject)
    protected
      name: String;
      abbv: String;
      subdivisions: TList;
    public
      constructor Create(name, abbv: String); overload;
      constructor Create(name, abbv: String; counties: TList); overload;
      procedure addCounty(new_county: TCounty);
  end;

  TCountry = packed class(TState)
    public
      constructor Create(name, abbv: String; states: TList); overload;
      procedure addState(new_state: TState);
  end;

  TAddressName = packed class(TObject)
    protected
      number: Integer;
      name: String;
    {private
      function getDesc: String;}
    public
      constructor Create(number: Integer; name: String); overload;
    {published
      property desc: String
        read getDesc;}
    end;

  TLocation = packed class(TObject)
    protected
      address: TAddressName;
      city: TCity;
      county: TCounty;
      state: TState;
      country: TCountry;
    private
      function getDesc: String;
    public
      constructor Create(address: TAddressName; city: TCity; county: TCounty; state: TState; country: TCountry); overload;
    published
      property desc: String
        read getDesc;
  end;

  TAddress = packed class(TObject)
    protected
      addr1: TAddressName;
      addr2: TAddressName;
      city: TCity;
      state: TState;
      country: TCountry;
      zip: String;
    private
      function getDesc: String;
    public
      constructor Create(addr1, addr2: TAddressName; city: TCity; state: TState; country: TCountry; zip: string); overload;
      constructor Create(location: TLocation; zip: string); overload;
    published
      property desc: String
        read getDesc;
  end;

  function formatAsMailAddress(recipient: String; address: TAddress): String;
  function formatAsAddress(address: TAddress): String;

var
  Form1: TForm1;
  address: TAddress;
  location: TLocation;
  citytype: CityTypes;
  admintype: AdministrativeTypes;
  cities, counties, states, countries, addresses: TList;

implementation

uses Mod1, TapeOutTbls;

{$R *.dfm}

constructor TCity.Create(name: String; type_: CityTypes; admin_type: AdministrativeTypes);
begin
  self.name := name;
  self.type_ := type_;
  self.admin_type := admin_type;
end;

constructor TCounty.Create(name: String);
begin
  self.name := name;
  self.subdivisions := TList.Create;
end;

constructor TCounty.Create(name: String; cities: TList);
begin
  self.name := name;
  self.subdivisions := cities;
end;

procedure TCounty.addCity(new_city: TCity);
begin
  self.subdivisions.add(new_city);
end;

function TCounty.getDesc: String;
begin
  Result := self.name + ' County';
end;

constructor TState.Create(name, abbv: String);
begin
  self.name := name;
  self.subdivisions := TList.Create;
  self.abbv := abbv;
end;

constructor TState.Create(name, abbv: String; counties: TList);
begin
  self.name := name;
  self.subdivisions := counties;
  self.abbv := abbv;
end;

procedure TState.addCounty(new_county: TCounty);
begin
  self.subdivisions.add(new_county);
end;

constructor TCountry.Create(name, abbv: string; states: TList);
begin
  self.name := name;
  self.subdivisions := states;
  self.abbv := abbv;
end;

procedure TCountry.addState(new_state: TState);
begin
  self.subdivisions.add(new_state);
end;

constructor TAddressName.Create(number: Integer; name: String);
begin
  self.number := number;
  self.name := name;
end;

{function TAddressName.getDesc: String;
begin
Result := trim(inttostr(self.number) + ' ' + self.name);
end;}

constructor TAddress.Create(addr1, addr2: TAddressName; city: TCity; state: TState; country: TCountry; zip: string);
begin
  self.addr1 := addr1;
  self.addr2 := addr2;
  self.city := city;
  self.state := state;
  self.country := country;
  self.zip := zip;
end;

constructor TAddress.Create(location: TLocation; zip: string);
begin
  self.addr1 := location.address;
  self.addr2 := TAddressName.Create;
  self.city := location.city;
  self.state := location.state;
  self.country := location.country;
  self.zip := zip;
end;

function TAddress.getDesc: String;
begin
  Result := inttostr(self.addr1.number) + ' ' + self.addr1.name;
  if (self.addr2 <> nil) then
    Result := Result + trim(' ' + self.addr2.name);
  Result := Result + ', ' + self.city.name + ', ';
  if (self.state <> nil) then
    begin
    if (self.state.name <> '') then
      Result := Result + self.state.name
    else
      Result := Result + self.country.name;
    end
  else
    Result := Result + self.country.name;
  Result := trim(Result + ' ' + self.zip);
end;

constructor TLocation.Create(address: TAddressName; city: TCity; county: TCounty; state: TState; country: TCountry);
begin
  self.address := address;
  self.city := city;
  self.county := county;
  self.state := state;
  self.country := country;
end;

{constructor TLocation.Create(address: TAddress);
begin
  self.address := address.addr1;
  self.city := address.city;
  self.county := address.county;
  self.state := address.state;
  self.country := address.country;
end;}

function TLocation.getDesc: String;
begin
Result := inttostr(self.address.number) + ' ' + self.address.name + ', ' + self.city.name + ', ' + self.county.desc;
if (self.state <> nil) then
  begin
  if (self.state.name <> '') then
    Result := Result + ', ' + self.state.name;
  end;
Result := trim(Result + ', ' + self.country.name);
end;

function formatAsMailAddress(recipient: String; address: TAddress): String;
begin
  Result := recipient + AnsiString(#13#10);
  Result := Result + inttostr(address.addr1.number) + ' ' + address.addr1.name + AnsiString(#13#10);

  Result := Result + address.city.name;
  if (address.state <> nil) then
    begin
    if (address.state.name <> '') then
      Result := Result + ', ' + address.state.name;
    end;
    
  Result := Result + ' ' + address.zip + AnsiString(#13#10);
  Result := Result + address.country.name;
end;

function formatAsAddress(address: TAddress): String;
begin
  Result := inttostr(address.addr1.number) + ' ' + address.addr1.name + ', ' + address.city.name + ', ';
  if (address.state <> nil) then
    begin
    if (address.state.name <> '') then
      Result := Result + address.state.name + ', ';
    end;

  Result := Result + address.country.name + ' ' + address.zip;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
{ADBData := TDBData.Create;
CreateClientServerObj(ADBData,dmMod1);

tblAccountGroupsAccounts := ADBData.AddATable('tblAccountGroupsAccounts',ttAccountGroupsAccounts,dbdiTable,false,dbdiQuery);}

cities := TList.Create;
counties := TList.Create;
states := TList.Create;
countries := TList.Create;
addresses := TList.Create;

Panel1.BringToFront;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
//FreeAndNil(ADBData);
  FreeAndNil(address);
//  FreeAndNil(mycity);
//  FreeAndNil(county);
//  FreeAndNil(country);
//  FreeAndNil(state);
  FreeAndNil(location);
//  FreeAndNil(address_name);
end;

procedure TForm1.btnShowClick(Sender: TObject);
begin
  Panel1.BringToFront;
  
  memo1.Lines.Clear;
  memo1.Lines.Append(address.desc);
  memo1.Lines.Append('');
  memo1.Lines.Append(location.desc);
  memo1.Lines.Append('');
  memo1.Lines.Append(formatAsMailAddress('Brendan Beard', address));
  memo1.Lines.Append('');
  memo1.Lines.Append(formatAsAddress(address));
end;

procedure TForm1.rgCityTypesClick(Sender: TObject);
begin
  case rgCityTypes.ItemIndex of
    0: citytype := Lost;
    1: citytype := Site;
    2: citytype := Community;
    3: citytype := Town;
    4: citytype := City;
  end;
end;

procedure TForm1.rgAdminTypesClick(Sender: TObject);
begin
  case rgAdminTypes.ItemIndex of
    0: admintype := None;
    1: admintype := Seat;
    2: admintype := Capital;
  end;
end;

procedure TForm1.btnAddCityClick(Sender: TObject);
begin
  Panel2.Enabled := true;
  Panel2.BringToFront;
end;

procedure TForm1.btnCreateCityClick(Sender: TObject);
var
  mycity: TCity;
begin
  mycity := TCity.Create(edtCityName.Text, citytype, admintype);
  cities.add(mycity);
  cbCities.Items.Append(mycity.name);

  // Clear
  edtCityName.Text := '';
  rgCityTypes.ItemIndex := 0;
  rgAdminTypes.ItemIndex := 0;

  Panel2.Enabled := false;
  Panel2.SendToBack;
end;

procedure TForm1.btnAddCountyClick(Sender: TObject);
begin
  Panel3.Enabled := true;
  Panel3.BringToFront;
end;

procedure TForm1.btnCreateCountyClick(Sender: TObject);
var
  county: TCounty;
begin
  county := TCounty.Create(edtCountyName.Text, cities);
  counties.add(county);
  cbCounties.Items.Append(county.name);

  //Clear
  edtCountyName.Text := '';

  Panel3.Enabled := false;
  Panel3.SendToBack;
end;

procedure TForm1.btnCreateCountryClick(Sender: TObject);
var
  state: TState;
  country: TCountry;
begin
  if (edtStateName.Text <> '') then
    begin
    state := TState.Create(edtStateName.Text, '', counties);
    states.add(state);
    cbStates.Items.Append(state.name);

    edtStateName.Text := '';
    end;

  if (edtCountryName.Text <> '') then
    begin
    country := TCountry.Create(edtCountryName.Text, '', states);
    countries.Add(country);
    cbCountries.Items.Append(country.name);

    edtCountryName.Text := '';
    end;

  Panel4.Enabled := false;
  Panel4.SendToBack;
end;

procedure TForm1.btnAddCountryClick(Sender: TObject);
begin
  Panel4.Enabled := true;
  Panel4.BringToFront;
end;

procedure TForm1.btnAddAddressClick(Sender: TObject);
begin
Panel5.Enabled := true;
Panel5.BringToFront;
end;

procedure TForm1.btnCreateAddressClick(Sender: TObject);
var
  apt_num, addrName: String;
  address_name, address_name2: TAddressName;
  city2: TCity;
  state: TState;
  country: TCountry;

begin
  apt_num := '';
  if (edtAptNum.Text <> '') then
    apt_num := '#' + edtAptNum.Text;

  addrName := trim(edtAddrName.Text + ' ' + apt_num);
  address_name := TAddressName.Create(strtoint(edtAddrNum.Text), addrName);
  address_name2 := TAddressName.Create;

  city2 := TCity.Create;
  state := TState.Create;
  country := TCountry.Create;

  address := TAddress.Create(address_name, address_name2, city2, state, country, edtAddrZip.Text);
  addresses.Add(address);
  cbAddresses.Items.Append(address.addr1.name);

  //Clear
  edtAddrName.Text := '';
  edtAddrNum.Text := '';
  edtAptNum.Text := '';
  edtAddrZip.Text := '';

  Panel5.Enabled := false;
  Panel5.SendToBack;
end;

procedure TForm1.btnCreateClick(Sender: TObject);
begin
location := TLocation.Create;
location.address := TAddress(addresses.Items[cbAddresses.ItemIndex]).addr1;
location.city := TCity(cities.Items[cbCities.ItemIndex]);
location.county := TCounty(counties.Items[cbCounties.ItemIndex]);
if (cbStates.ItemIndex <> -1) then
  location.state := TState(states.Items[cbStates.ItemIndex]);
location.country := TCountry(countries.Items[cbCountries.ItemIndex]);

address := TAddress.Create(location, '77845');
end;

end.
