unit firebirdupdateu1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IBConnection, sqldb, FileUtil, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ComCtrls;

type

  { TFrmAdressbook }

  TFrmAdressbook = class(TForm)
    BtnSelectData: TButton;
    BtnUpdateData: TButton;
    BtnNewData: TButton;
    BtnInsertData: TButton;
    BtnDelete: TButton;
    BtnSearch: TButton;
    BtnDeleteFilter: TButton;
    CBSearchField: TComboBox;
    EdtIndex: TEdit;
    EdtSearch: TEdit;
    EdtDescId: TEdit;
    EdtAdressDisplayname: TEdit;
    EdtAdressEMail: TEdit;
    EdtAdressFirstname: TEdit;
    EdtAdressID: TEdit;
    EdtAdressLastname: TEdit;
    EdtAdressLoginname: TEdit;
    EdtAdressMobile: TEdit;
    EdtAdressPassword: TEdit;
    EdtAdressTel: TEdit;
    IBConnection1: TIBConnection;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LVAdressbook: TListView;
    PageControl1: TPageControl;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure BtnDeleteClick(Sender: TObject);
    procedure BtnDeleteFilterClick(Sender: TObject);
    procedure BtnSearchClick(Sender: TObject);
    procedure BtnSelectDataClick(Sender: TObject);
    procedure BtnUpdateDataClick(Sender: TObject);
    procedure BtnNewDataClick(Sender: TObject);
    procedure BtnInsertDataClick(Sender: TObject);
    procedure connectDB;
    procedure closeDB;
    procedure FormShow(Sender: TObject);
    procedure LVAdressbookClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;
   procedure AddDataToLV(id, firstname, lastname, tel, mobile : string);

var
  FrmAdressbook: TFrmAdressbook;

implementation
{$R *.lfm}

{ TFrmAdressbook }

procedure TFrmAdressbook.BtnSelectDataClick(Sender: TObject);
var
  strUserDeleteStatus : string;
begin
  strUserDeleteStatus := '0';

  //Datenbank Verbindung aufbauen
  FrmAdressbook.connectDB;

  // Datenbank Abfrage starten
  FrmAdressbook.SQLQuery1.SQL.Text     := 'SELECT * FROM AWUSERS WHERE USER_DELETE LIKE  = '''+strUserDeleteStatus+''';';
  FrmAdressbook.SQLQuery1.Active       := true;

  // Editfelder aus Datenbank füllen
  EdtAdressID.Text                     := FrmAdressbook.SQLQuery1.FieldbyName('USER_ID').AsString;
  EdtAdressFirstname.Text              := FrmAdressbook.SQLQuery1.FieldbyName('USER_FIRSTNAME').AsString;
  EdtAdressLastname.Text               := FrmAdressbook.SQLQuery1.FieldbyName('USER_LASTNAME').AsString;
  EdtAdressLoginname.Text              := FrmAdressbook.SQLQuery1.FieldbyName('USER_LOGINNAME').AsString;
  EdtAdressDisplayname.Text            := FrmAdressbook.SQLQuery1.FieldbyName('USER_DISPLAYNAME').AsString;
  EdtAdressPassword.Text               := FrmAdressbook.SQLQuery1.FieldbyName('USER_PASSWORD').AsString;
  EdtAdressTel.Text                    := FrmAdressbook.SQLQuery1.FieldbyName('USER_TEL').AsString;
  EdtAdressMobile.Text                 := FrmAdressbook.SQLQuery1.FieldbyName('USER_MOBILE').AsString;
  EdtAdressEMail.Text                  := FrmAdressbook.SQLQuery1.FieldbyName('USER_EMAIL').AsString;

  // Datenbank Verbindung schließen.
  FrmAdressbook.closeDB;
end;

procedure TFrmAdressbook.BtnDeleteClick(Sender: TObject);
Var
strAdressID : string;
strAdressDelStatus : string;
begin
  strAdressID        := EdtAdressID.Text;
  strAdressDelStatus := '1';
    // Datenbank Verbindung herstellen
  FrmAdressbook.connectDB;

  // Datenbank Update durchführen
  FrmAdressbook.SQLQuery1.SQL.Text := 'Update AWUSERS SET USER_DELETE = '''+strAdressDelStatus+''' WHERE USER_ID = '''+strAdressID+''';';
  LVAdressbook.Selected.Delete;

  // Datenbank Verbindung schließen
  FrmAdressbook.closeDB;
end;

procedure TFrmAdressbook.BtnDeleteFilterClick(Sender: TObject);
var
  strUserID : string;
  strUserFirstname : string;
  strUserLastname : string;
  strUserTel : string;
  strUserMobile : string;
  strUserDeleteStatus : string;
begin

  // User Abruf Status festlegen
  strUserDeleteStatus := '0';

 //Datenbank Verbindung aufbauen
  FrmAdressbook.connectDB;

  // Datenbank Abfrage starten
  FrmAdressbook.SQLQuery1.SQL.Text     := 'SELECT * FROM AWUSERS WHERE USER_DELETE LIKE '''+strUserDeleteStatus+''';';
  FrmAdressbook.SQLQuery1.Active       := true;

  // Editfelder aus Datenbank füllen
  EdtAdressID.Text                     := FrmAdressbook.SQLQuery1.FieldbyName('USER_ID').AsString;
  EdtAdressFirstname.Text              := FrmAdressbook.SQLQuery1.FieldbyName('USER_FIRSTNAME').AsString;
  EdtAdressLastname.Text               := FrmAdressbook.SQLQuery1.FieldbyName('USER_LASTNAME').AsString;
  EdtAdressLoginname.Text              := FrmAdressbook.SQLQuery1.FieldbyName('USER_LOGINNAME').AsString;
  EdtAdressDisplayname.Text            := FrmAdressbook.SQLQuery1.FieldbyName('USER_DISPLAYNAME').AsString;
  EdtAdressPassword.Text               := FrmAdressbook.SQLQuery1.FieldbyName('USER_PASSWORD').AsString;
  EdtAdressTel.Text                    := FrmAdressbook.SQLQuery1.FieldbyName('USER_TEL').AsString;
  EdtAdressMobile.Text                 := FrmAdressbook.SQLQuery1.FieldbyName('USER_MOBILE').AsString;
  EdtAdressEMail.Text                  := FrmAdressbook.SQLQuery1.FieldbyName('USER_EMAIL').AsString;

  // Datenbank Verbindung schließen.
  FrmAdressbook.closeDB;

 FrmAdressbook.connectDB;
 FrmAdressbook.SQLQuery1.SQL.Text := 'SELECT * FROM AWUSERS WHERE USER_DELETE LIKE '''+strUserDeleteStatus+''';';
 FrmAdressbook.SQLQuery1.Open;

 // Listview löschen
 LVAdressbook.Clear();

 while not FrmAdressbook.SQLQuery1.Eof do
 begin
    //Datenbank Abfrage und füllen der variablen
   strUserID           := FrmAdressbook.SQLQuery1.FieldByName('USER_ID').AsString;
   strUserFirstname    := FrmAdressbook.SQLQuery1.FieldbyName('USER_FIRSTNAME').AsString;
   strUserLastname     := FrmAdressbook.SQLQuery1.FieldByName('USER_LASTNAME').AsString;
   strUserTel          := FrmAdressbook.SQLQuery1.FieldByName('USER_TEL').AsString;
   strUserMobile       := FrmAdressbook.SQLQuery1.FieldByName('USER_MOBILE').AsString;

   addDataToLV(strUserID, strUserFirstname, strUserLastname, strUserTel, strUserMobile);
   FrmAdressbook.SQLQuery1.next;
 end;
 // Datenbank Verbindung schließen
 FrmAdressbook.closeDB;

end;

procedure TFrmAdressbook.BtnSearchClick(Sender: TObject);
var
  strUserID : string;
  strUserFirstname : string;
  strUserLastname : string;
  strUserTel : string;
  strUserMobile : string;
  strUserDeleteStatus : string;
  strSearch  : string;
  strSearchField : String;
begin
 // User Abruf Status festlegen
  strUserDeleteStatus := '0';
  strSearch :=  EdtSearch.Text;

  if CBSearchField.ItemIndex = 0 then
  Begin
   strSearchField := 'USER_FIRSTNAME';
  end;

  if CBSearchField.ItemIndex = 1 then
  Begin
   strSearchField := 'USER_LASTNAME';
  end;

  EdtIndex.Text := IntToStr(CBSearchField.ItemIndex) + strSearchField;

  //Datenbank Verbindung aufbauen
  FrmAdressbook.connectDB;

  // Datenbank Abfrage starten
  FrmAdressbook.SQLQuery1.SQL.Text     := 'SELECT * FROM AWUSERS WHERE USER_DELETE LIKE '''+strUserDeleteStatus+''' AND '+strSearchField+' LIKE '''+strSearch+''';';
  FrmAdressbook.SQLQuery1.Active       := true;

  // Editfelder aus Datenbank füllen
  EdtAdressID.Text                     := FrmAdressbook.SQLQuery1.FieldbyName('USER_ID').AsString;
  EdtAdressFirstname.Text              := FrmAdressbook.SQLQuery1.FieldbyName('USER_FIRSTNAME').AsString;
  EdtAdressLastname.Text               := FrmAdressbook.SQLQuery1.FieldbyName('USER_LASTNAME').AsString;
  EdtAdressLoginname.Text              := FrmAdressbook.SQLQuery1.FieldbyName('USER_LOGINNAME').AsString;
  EdtAdressDisplayname.Text            := FrmAdressbook.SQLQuery1.FieldbyName('USER_DISPLAYNAME').AsString;
  EdtAdressPassword.Text               := FrmAdressbook.SQLQuery1.FieldbyName('USER_PASSWORD').AsString;
  EdtAdressTel.Text                    := FrmAdressbook.SQLQuery1.FieldbyName('USER_TEL').AsString;
  EdtAdressMobile.Text                 := FrmAdressbook.SQLQuery1.FieldbyName('USER_MOBILE').AsString;
  EdtAdressEMail.Text                  := FrmAdressbook.SQLQuery1.FieldbyName('USER_EMAIL').AsString;

  // Datenbank Verbindung schließen.
  FrmAdressbook.closeDB;

 FrmAdressbook.connectDB;
 FrmAdressbook.SQLQuery1.SQL.Text     := 'SELECT * FROM AWUSERS WHERE USER_DELETE LIKE '''+strUserDeleteStatus+''' AND '+strSearchField+' LIKE '''+strSearch+''';';
 FrmAdressbook.SQLQuery1.Open;

 LVAdressbook.Clear();

 while not FrmAdressbook.SQLQuery1.Eof do
 begin
    //Datenbank Abfrage und füllen der variablen
   strUserID           := FrmAdressbook.SQLQuery1.FieldByName('USER_ID').AsString;
   strUserFirstname    := FrmAdressbook.SQLQuery1.FieldbyName('USER_FIRSTNAME').AsString;
   strUserLastname     := FrmAdressbook.SQLQuery1.FieldByName('USER_LASTNAME').AsString;
   strUserTel          := FrmAdressbook.SQLQuery1.FieldByName('USER_TEL').AsString;
   strUserMobile       := FrmAdressbook.SQLQuery1.FieldByName('USER_MOBILE').AsString;

   AddDataToLV(strUserID, strUserFirstname, strUserLastname, strUserTel, strUserMobile);

   FrmAdressbook.SQLQuery1.next;
 end;
 // Datenbank Verbindung schließen
 FrmAdressbook.closeDB;
end;

procedure AddDataToLV(id, firstname, lastname, tel, mobile : string);
var
  item : TListItem;
begin
  item := FrmAdressbook.LVAdressbook.Items.Add;
  item.caption := id;
  item.SubItems.Add(firstname);
  item.SubItems.Add(lastname);
  item.SubItems.Add(tel);
  item.SubItems.Add(mobile);
end;

procedure TFrmAdressbook.BtnUpdateDataClick(Sender: TObject);
var
  // Variablen Deklaration
  strAdressID            : string;
  strAdressFirstname     : string;
  strAdressLastname      : string;
  strAdressLoginname     : string;
  strAdressDisplayname   : string;
  strAdressPassword      : string;
  strAdressTel           : string;
  strAdressMobile        : string;
  strAdressEMAil         : string;
begin

  {*************************************************************************
   *** Update Procedure
   *************************************************************************}

  // Variablen mit den Inhalten der Editfelder füllen.
  strAdressID            :=   EdtAdressID.Text;
  strAdressFirstname     :=   EdtAdressFirstname.Text;
  strAdressLastname      :=   EdtAdressLastname.Text;
  strAdressLoginname     :=   EdtAdressLoginname.Text;
  strAdressDisplayname   :=   EdtAdressDisplayname.Text;
  strAdressPassword      :=   EdtAdressPassword.Text;
  strAdressTel           :=   EdtAdressTel.Text;
  strAdressMobile        :=   EdtAdressMobile.Text;
  strAdressEMAil         :=   EdtAdressEMail.Text;

  // Datenbank Verbindung herstellen
  FrmAdressbook.connectDB;

  // Datenbank Update durchführen
  FrmAdressbook.SQLQuery1.SQL.Text := 'Update AWUSERS SET USER_ID = '''+strAdressID+''', USER_FIRSTNAME = '''+strAdressFirstname+''', USER_LASTNAME = '''+strAdressLastname+''', USER_LOGINNAME = '''+strAdressLoginname+''', USER_DISPLAYNAME = '''+strAdressDisplayname+''', USER_PASSWORD = '''+strAdressPassword+''', USER_TEL = '''+strAdressTel+''', USER_MOBILE = '''+strAdressMobile+''', USER_EMAIL = '''+strAdressEMail+''' WHERE USER_ID = '''+strAdressID+''';';

  // Datenbank Verbindung schließen
  FrmAdressbook.closeDB;


end;

procedure TFrmAdressbook.BtnNewDataClick(Sender: TObject);
begin
  EdtAdressID.enabled := false;
  EdtAdressID.Text                     := '';
  EdtAdressFirstname.Text              := '';
  EdtAdressLastname.Text               := '';
  EdtAdressLoginname.Text              := '';
  EdtAdressDisplayname.Text            := '';
  EdtAdressPassword.Text               := '';
  EdtAdressTel.Text                    := '';
  EdtAdressMobile.Text                 := '';
  EdtAdressEMail.Text                  := '';

end;

procedure TFrmAdressbook.BtnInsertDataClick(Sender: TObject);
var
  // Variablen Deklaration
  strAdressID            : string;
  intAdressID            : integer;
  strAdressFirstname     : string;
  strAdressLastname      : string;
  strAdressLoginname     : string;
  strAdressDisplayname   : string;
  strAdressPassword      : string;
  strAdressTel           : string;
  strAdressMobile        : string;
  strAdressEMAil         : string;

begin
  {*************************************************************************
   *** Insert Procedure
   *************************************************************************}

  // Variablen mit den Inhalten der Editfelder füllen.
  strAdressID            :=   EdtAdressID.Text;
  strAdressFirstname     :=   EdtAdressFirstname.Text;
  strAdressLastname      :=   EdtAdressLastname.Text;
  strAdressLoginname     :=   EdtAdressLoginname.Text;
  strAdressDisplayname   :=   EdtAdressDisplayname.Text;
  strAdressPassword      :=   EdtAdressPassword.Text;
  strAdressTel           :=   EdtAdressTel.Text;
  strAdressMobile        :=   EdtAdressMobile.Text;
  strAdressEMAil         :=   EdtAdressEMail.Text;

  //Datenbank Verbindung 1 aufbauen
    //Datenbank Verbindung aufbauen
  FrmAdressbook.connectDB;

  // Datenbank Abfrage starten
  FrmAdressbook.SQLQuery1.SQL.Text     := 'SELECT * FROM AWUSERS ORDER BY USER_ID DESC';
  FrmAdressbook.SQLQuery1.Active       := true;

  // Editfelder aus Datenbank füllen
  strAdressID                     := FrmAdressbook.SQLQuery1.FieldbyName('USER_ID').AsString;

  //Neue ID +1
  intAdressID := StrToInt(strAdressID);
  intAdressID := intAdressID + 1;
  strAdressID := IntToStr(intAdressID);
  EdtDescId.Text := strAdressID;

  //Datenbank Verbindung 2 aufbauen
  FrmAdressbook.connectDB;

  //Datenbank Eintrag hinzufügen
  FrmAdressbook.SQLQuery1.SQL.Text := 'INSERT INTO AWUSERS (USER_ID, USER_FIRSTNAME, USER_LASTNAME, USER_LOGINNAME, USER_DISPLAYNAME, USER_PASSWORD, USER_TEL, USER_MOBILE, USER_EMAIL) VALUES('''+strAdressID+''', '''+strAdressFirstname+''', '''+strAdressLastname+''', '''+strAdressLoginname+''', '''+strAdressDisplayname+''', '''+strAdressPassword+''', '''+strAdressTel+''', '''+strAdressMobile+''', '''+strAdressEMAil+''')';

  // Datenbank Verbindung schließen
  FrmAdressbook.closeDB;

  // ListView insert
  AddDataToLV(strAdressID, strAdressFirstname, strAdressLastname, strAdressTel, strAdressMobile);

  EdtAdressID.enabled := true;
end;


procedure TFrmAdressbook.connectDB;
begin
   IBConnection1.Hostname          := 'localhost';
   IBConnection1.UserName          := 'SYSDBA';
   IBConnection1.Password          := 'masterkey';
   IBConnection1.DatabaseName      := ExtractFilePath(Application.ExeName) + 'AWUSER.FDB';
   IBConnection1.Transaction       := SQLTransaction1;
   IBConnection1.Connected         := true;
   SQLQuery1.Database              := IBConnection1;
end;

procedure TFrmAdressbook.closeDB;
begin
   SQLQuery1.Active := false;
   SQLQuery1.ExecSQL;
   SQLTransaction1.Commit;
end;

procedure TFrmAdressbook.FormShow(Sender: TObject);
var
  strUserID : string;
  strUserFirstname : string;
  strUserLastname : string;
  strUserTel : string;
  strUserMobile : string;
  strUserDeleteStatus : string;
begin

  // User Abruf Status festlegen
  strUserDeleteStatus := '0';

 //Datenbank Verbindung aufbauen
  FrmAdressbook.connectDB;

  // Datenbank Abfrage starten
  FrmAdressbook.SQLQuery1.SQL.Text     := 'SELECT * FROM AWUSERS WHERE USER_DELETE LIKE '''+strUserDeleteStatus+''';';
  FrmAdressbook.SQLQuery1.Active       := true;

  // Editfelder aus Datenbank füllen
  EdtAdressID.Text                     := FrmAdressbook.SQLQuery1.FieldbyName('USER_ID').AsString;
  EdtAdressFirstname.Text              := FrmAdressbook.SQLQuery1.FieldbyName('USER_FIRSTNAME').AsString;
  EdtAdressLastname.Text               := FrmAdressbook.SQLQuery1.FieldbyName('USER_LASTNAME').AsString;
  EdtAdressLoginname.Text              := FrmAdressbook.SQLQuery1.FieldbyName('USER_LOGINNAME').AsString;
  EdtAdressDisplayname.Text            := FrmAdressbook.SQLQuery1.FieldbyName('USER_DISPLAYNAME').AsString;
  EdtAdressPassword.Text               := FrmAdressbook.SQLQuery1.FieldbyName('USER_PASSWORD').AsString;
  EdtAdressTel.Text                    := FrmAdressbook.SQLQuery1.FieldbyName('USER_TEL').AsString;
  EdtAdressMobile.Text                 := FrmAdressbook.SQLQuery1.FieldbyName('USER_MOBILE').AsString;
  EdtAdressEMail.Text                  := FrmAdressbook.SQLQuery1.FieldbyName('USER_EMAIL').AsString;

  // Datenbank Verbindung schließen.
  FrmAdressbook.closeDB;

 FrmAdressbook.connectDB;
 FrmAdressbook.SQLQuery1.SQL.Text := 'SELECT * FROM AWUSERS WHERE USER_DELETE LIKE '''+strUserDeleteStatus+''';';
 FrmAdressbook.SQLQuery1.Open;

 while not FrmAdressbook.SQLQuery1.Eof do
 begin
    //Datenbank Abfrage und füllen der variablen
   strUserID           := FrmAdressbook.SQLQuery1.FieldByName('USER_ID').AsString;
   strUserFirstname    := FrmAdressbook.SQLQuery1.FieldbyName('USER_FIRSTNAME').AsString;
   strUserLastname     := FrmAdressbook.SQLQuery1.FieldByName('USER_LASTNAME').AsString;
   strUserTel          := FrmAdressbook.SQLQuery1.FieldByName('USER_TEL').AsString;
   strUserMobile       := FrmAdressbook.SQLQuery1.FieldByName('USER_MOBILE').AsString;

   addDataToLV(strUserID, strUserFirstname, strUserLastname, strUserTel, strUserMobile);
   FrmAdressbook.SQLQuery1.next;
 end;
 // Datenbank Verbindung schließen
 FrmAdressbook.closeDB;
end;

procedure TFrmAdressbook.LVAdressbookClick(Sender: TObject);
var
  strUserID : string;
begin
  strUserID := LVAdressbook.Selected.Caption;

  //Datenbank Verbindung aufbauen
  FrmAdressbook.connectDB;

  // Datenbank Abfrage starten
  FrmAdressbook.SQLQuery1.SQL.Text     := 'SELECT * FROM AWUSERS WHERE USER_ID = '''+strUserID+''';';
  FrmAdressbook.SQLQuery1.Active       := true;

  // Editfelder aus Datenbank füllen
  EdtAdressID.Text                     := FrmAdressbook.SQLQuery1.FieldbyName('USER_ID').AsString;
  EdtAdressFirstname.Text              := FrmAdressbook.SQLQuery1.FieldbyName('USER_FIRSTNAME').AsString;
  EdtAdressLastname.Text               := FrmAdressbook.SQLQuery1.FieldbyName('USER_LASTNAME').AsString;
  EdtAdressLoginname.Text              := FrmAdressbook.SQLQuery1.FieldbyName('USER_LOGINNAME').AsString;
  EdtAdressDisplayname.Text            := FrmAdressbook.SQLQuery1.FieldbyName('USER_DISPLAYNAME').AsString;
  EdtAdressPassword.Text               := FrmAdressbook.SQLQuery1.FieldbyName('USER_PASSWORD').AsString;
  EdtAdressTel.Text                    := FrmAdressbook.SQLQuery1.FieldbyName('USER_TEL').AsString;
  EdtAdressMobile.Text                 := FrmAdressbook.SQLQuery1.FieldbyName('USER_MOBILE').AsString;
  EdtAdressEMail.Text                  := FrmAdressbook.SQLQuery1.FieldbyName('USER_EMAIL').AsString;

  // Datenbank Verbindung schließen.
  FrmAdressbook.closeDB;

end;

end.

