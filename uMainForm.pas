unit uMainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls; {FileCtrl, Registry, IniFiles, DB, dbisamtb, entryprog,
  Grids, DBGrids, ClientServer, objDBDataItem, TypeDecsDB, objDBData;}

type
  TForm1 = class(TForm)
    btnShow: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnShowClick(Sender: TObject);
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

  TAddress = packed class(TObject)
    protected
      addr1: TAddressName;
      addr2: TAddressName;
      city: TCity;
      state: TState;
      zip: String;
    private
      function getDesc: String;
    public
      constructor Create(addr1, addr2: TAddressName; city: TCity; state: TState; zip: string); overload;
    published
      property desc: String
        read getDesc;
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

var
  Form1: TForm1;
  address_name: TAddressName;
  address: TAddress;
  myCity: TCity;
  county: TCounty;
  state: TState;
  country: TCountry;
  location: TLocation;

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

constructor TAddress.Create(addr1, addr2: TAddressName; city: TCity; state: TState; zip: string);
begin
  self.addr1 := addr1;
  self.addr2 := addr2;
  self.city := city;
  self.state := state;
  self.zip := zip;
end;

function TAddress.getDesc: String;
begin
Result := self.addr1.name;
if (self.addr2 <> nil) then
  Result := Result + trim(' ' + self.addr2.name);
Result := Result + ', ' + self.city.name + ', ' + self.state.name + ' ' + self.zip;
end;

constructor TLocation.Create(address: TAddressName; city: TCity; county: TCounty; state: TState; country: TCountry);
begin
  self.address := address;
  self.city := city;
  self.county := county;
  self.state := state;
  self.country := country;
end;

function TLocation.getDesc: String;
begin
Result := trim(self.address.name + ', ' + self.city.name + ', ' + self.county.desc + ', ' + self.state.name + ', ' + self.country.name);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
cities, counties, states: TList;
begin
{ADBData := TDBData.Create;
CreateClientServerObj(ADBData,dmMod1);

tblAccountGroupsAccounts := ADBData.AddATable('tblAccountGroupsAccounts',ttAccountGroupsAccounts,dbdiTable,false,dbdiQuery);}

mycity := TCity.Create('College Station', City, None);

cities := TList.Create;
cities.add(mycity);

county := TCounty.Create('Brazos', cities);

counties := TList.Create;
counties.add(county);

state := TState.Create('Texas', 'TX', counties);

states := TList.Create;
states.add(state);

country := TCountry.Create('United States of America', 'U.S.A', states);

address_name := TAddressName.Create(2701, 'Longmire Dr. #1405');

address := TAddress.Create;
address.addr1 := address_name;
address.city := mycity;
address.state := state;
address.zip := '77845';

location := TLocation.Create;
location.address := address_name;
location.city := mycity;
location.county := county;
location.state := state;
location.country := country;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
//FreeAndNil(ADBData);
FreeAndNil(address);
FreeAndNil(mycity);
FreeAndNil(county);
FreeAndNil(country);
FreeAndNil(state);
FreeAndNil(location);
end;

procedure TForm1.btnShowClick(Sender: TObject);
begin
ShowMessage(address.desc);
ShowMessage(location.desc);
end;

end.
