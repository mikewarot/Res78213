unit MainForm;

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ComCtrls,
  StdCtrls, ValEdit, Grids;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ButtonLoadLabels: TButton;
    ButtonSaveLabels: TButton;
    EditAddress: TEdit;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuHelpAbout: TMenuItem;
    MenuFileOpen: TMenuItem;
    MenuFileExit: TMenuItem;
    MenuItem3: TMenuItem;
    Separator1: TMenuItem;
    OpenDialog1: TOpenDialog;
    StatusBar1: TStatusBar;
    LabelList: TValueListEditor;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ButtonLoadLabelsClick(Sender: TObject);
    procedure ButtonSaveLabelsClick(Sender: TObject);
    procedure EditAddressChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuHelpAboutClick(Sender: TObject);
    procedure MenuFileExitClick(Sender: TObject);
    procedure MenuFileOpenClick(Sender: TObject);
    procedure MenuSaveClick(Sender: TObject);
    procedure MenuOpenClick(Sender: TObject);
    procedure ValueListEditor1Click(Sender: TObject);
  private

  public

  end;

  tMode = (Vector,Instruction);

const
  MemSize = 65536;
  RP2  : Array[0..3] of String = ('AX','BC','DE','HL');
  Reg8 : Array[0..7] Of String = ('X','A','C','B','E','D','L','H');
  Mem1 : Array[0..1] of String = ('[DE]','[HL]');
  MemShort : Array[0..5] of String = ('[DE+]','[HL+]','[DE-]','[HL-]','[DE]','[HL]');
  R1   : Array[0..1] of String = ('C','B');

var
  Form1: TForm1;
  BinarySource : Array[0..MemSize] of byte;
  SourceSize : LongInt;
  SourceOffset : Longint;
  unknown  : Longint;

implementation

{$R *.lfm}

{ TForm1 }

Function MemoryMode(Addr : LongInt): tMode;
begin
  if Addr <= $80 then
    MemoryMode := Vector
  else
    MemoryMode := Instruction;
end;

Function Y:Byte;
begin
  Y := BinarySource[SourceOffset];
  Inc(SourceOffset);
end;

Function OpWord:Integer;
var
  zz : Integer;
begin
  zz := (BinarySource[Sourceoffset+1] SHL 8) OR BinarySource[SourceOffset];
  Inc(SourceOffset,2);
  OpWord := zz;
end;

Function NiceAddress(Addr : Longint):String;
var
  Name,Key : string;
  Row : integer;
begin
  Row := 0;
  Key := Addr.ToHexString(4);
  Name := 'L_'+Key;
  If Form1.LabelList.FindRow(Key,Row) then
    Name := Form1.LabelList.Rows[Row].Strings[1]
  else
    Form1.LabelList.InsertRow(Key,Name,True);
  NiceAddress := Name;
//  Form1.Memo1.Append(Name);
end;

Function JumpOffset8:String;
var
  Offset : Int8;
  Destination : LongInt;
begin
  Offset := BinarySource[SourceOffset];
  Inc(SourceOffset);
  Destination := Sourceoffset + Offset;
  JumpOffset8 := Destination.ToHexString(4);
end;

Function Saddr:String;
var
  Offset : LongInt;
  Destination : LongInt;
begin
  Offset := BinarySource[SourceOffset];
  Inc(SourceOffset);
  If (Offset >= $20) then
    Destination := $FE00 + Offset
  else
    Destination := $FF00 + Offset;
  Saddr := Destination.ToHexString(4);
end;

Function Sfr:String;
var
  Offset : LongInt;
  Destination : LongInt;
begin
  Offset := BinarySource[SourceOffset];
  Inc(SourceOffset);
  Destination := $FF00 + Offset;
  Sfr := Destination.ToHexString(4);
end;


procedure Disassemble1; // disassemble the current instruction
var
  x,x2 : byte;
  s   : string;
  R   : Integer;
  addr : Word;
  OldOffset : LongInt;


begin
  OldOffset := SourceOffset;
  S := SourceOffset.ToHexString(4)+': ';

  R := 0;
  If Form1.LabelList.FindRow(SourceOffset.ToHexString(4),R) then
    S := Form1.LabelList.Rows[R].Strings[1]+ ': '
//    S := Form1.LabelList.Rows[R].Values['Label'] + ': '
  else
    Form1.LabelList.InsertRow(SourceOffset.ToHexString(4),'L_'+SourceOffset.ToHexString(4),True);

  If MemoryMode(SourceOffset) = Instruction then
    begin

      x := BinarySource[SourceOffset];
      inc(SourceOffset);
      Case X of
        $00             : S := S + 'NOP';
        $03             : begin
                            X2 := Y;
                            Case X2 of
                              $00..$07 : S := S + 'MOV1    CY,X.'+(X2 and 7).ToHexString(2);
                              $08..$0F : S := S + 'MOV1    CY,A.'+(X2 and 7).ToHexString(2);
                              $10..$17 : S := S + 'MOV1    X.'+(X2 and 7).ToHexString(2)+',CY';
                              $18..$1F : S := S + 'MOV1    A.'+(X2 and 7).ToHexString(2)+',CY';
                              $20..$27 : S := S + 'AND1    CY,X'+(X2 and 7).ToHexString(2);
                              $28..$2F : S := S + 'AND1    CY,A'+(X2 and 7).ToHexString(2);
                              $30..$37 : S := S + 'AND1    CY,/X'+(X2 and 7).ToHexString(2);
                              $38..$3F : S := S + 'AND1    CY,/A'+(X2 and 7).ToHexString(2);
                            else
                              S := S + 'Unknown Bit Manipulation Instruction '+X2.ToHexString(2);
                              Inc(Unknown);
                            end;
                          end;
        $05             : begin
                            X2 := Y;
                            Case X2 of
                              $E2..$E3 : S := S + 'MOVW    AX,'+Mem1[X2 AND 1];
                              $E6..$E7 : S := S + 'MOVW    '+Mem1[X2 AND 1]+',AX';
                            else
                              S := S + 'Unknown MOVW variant';
                              Inc(Unknown);
                            end;
                          end;
        $06             : begin
                            X2 := Y;
                            Case X2 of
                              $A0 : S := S + 'MOV     [HL+0'+Y.ToHexString(2)+'h],A';
                            else
                              S := S + 'Unkown MOV[ ],A variant';
                              Inc(Unknown);
                            end;
                          end;
        $08             : begin                     // condition branches
                            X2 := Y;
                            Case X2 of
                              $A0..$A7 : S := S + 'BF      ['+Saddr+'].'+(X2 and 7).ToHexString(2)+'  '+JumpOffset8;
                            else
                              S := S + 'Conditional branch '+X2.ToHexString(2);
                              Inc(Unknown);
                            end;

                          end;
        $0B             : S := S + 'MOVW    ['+Saddr+'],#'+ OpWord.ToHexString(4);
        $11             : S := S + 'MOVW    AX,'+Saddr;
        $13             : S := S + 'MOVW    '+Saddr+',AX';
        $14             : S := S + 'BR      '+JumpOffset8;
        $1A             : S := S + 'MOVW    ['+SFR+'],AX';
        $1C             : S := S + 'MOVW    AX,['+SFR+']';
        $24             : begin
                            X2 := Y;
                            S := S + 'MOVW    '+RP2[(X2 shr 5) AND 3] +','+RP2[(X2 shr 1) AND 3];
                          end;
        $26             : S := S + 'INC     ['+SFR+']';
        $27             : S := S + 'DEC     ['+SFR+']';
        $28             : S := S + 'CALL    '+OpWord.ToHexString(4);
        $2D             : S := S + 'ADDW    AX,#'+OpWord.ToHexString(4);
        $2E             : S := S + 'SUBW    AX,#'+OpWord.ToHexString(4);
        $2F             : S := S + 'CMPW    AX,#'+OpWord.ToHexString(4);
        $30             : begin
                            x2 := y;
                            Case (x2 shr 6) of
                              0   : S := S + 'RORC    '+Reg8[X2 and 7]+','+((X2 shr 3) and 7).ToHexString(1);
                              1   : S := S + 'ROR     '+Reg8[X2 and 7]+','+((X2 shr 3) and 7).ToHexString(1);
                              2   : S := S + 'SHR     '+Reg8[X2 and 7]+','+((X2 shr 3) and 7).ToHexString(1);
                              3   : S := S + 'SHRW    '+RP2[(X2 SHR 1) and 3]+((X2 shr 3) and 7).ToHexString(1);
                            end;
                          end;
        $31             : begin
                            x2 := y;
                            Case (x2 shr 6) of
                              0   : S := S + 'ROLC    '+Reg8[X2 and 7]+','+((X2 shr 3) and 7).ToHexString(1);
                              1   : S := S + 'ROL     '+Reg8[X2 and 7]+','+((X2 shr 3) and 7).ToHexString(1);
                              2   : S := S + 'SHL     '+Reg8[X2 and 7]+','+((X2 shr 3) and 7).ToHexString(1);
                              3   : S := S + 'SHLW    '+RP2[(X2 SHR 1) and 3]+((X2 shr 3) and 7).ToHexString(1);
                            end;
                          end;
        $32..$33        : S := S + 'DBNZ    '+R1[X and 1]+','+JumpOffset8;
        $34..$37        : S := S + 'POP     '+RP2[X and 3];
        $3A             : S := S + 'MOV     '+Saddr+',#'+Y.ToHexString(2);
        $3C..$3F        : S := S + 'PUSH    '+RP2[X and 3];
        $44..$47        : S := S + 'INCW    '+RP2[X and 3];
        $4A             : S := S + 'DI';
        $4B             : S := S + 'EI';
        $4C..$4F        : S := S + 'DECW    '+RP2[X and 3];
        $50..$55        : S := S + 'MOV     '+MemShort[X and 7]+',A';
        $56             : S := S + 'RET';
        $57             : S := S + 'RETI';
        $58..$5D        : S := S + 'MOV     A,'+MemShort[X and 7];
        $5E             : S := S + 'BRK';
        $5F             : S := S + 'RETB';
        $60,$62,$64,$66 : S := S + 'MOVW    '+RP2[(X shr 1) AND 3]+',#'+OpWord.ToHexString(4);
//        $65             : S := S + '
        $70..$77        : S := S + 'BT      '+Saddr+'.'+(X and 7).ToHexString(1)+','+JumpOffset8;
        $80             : S := S + 'BNZ     '+JumpOffset8;
        $A0..$A7        : S := S + 'CLR1    '+Saddr+'.'+(X and 7).ToHexString(1);
        $8A             : begin
                            x2 := y;
                            Case X2 of
                              $08,$0A,$0C,$0E : S := S + 'SUBW    AX,'+RP2[(x2 shr 1) AND 3];
                            else
                              S := S + 'SUB      '+Reg8[(x2 shr 4) AND 7]+','+Reg8[x2 AND 7];
                            end;
                          end;
        $B0..$B7        : S := S + 'SET1    '+Saddr+'.'+(X and 7).ToHexString(1);
        $B8..$BF        : S := S + 'MOV     '+Reg8[(X and 7)]+','+Y.ToHexString(2)+'h';
        $C0..$C7        : S := S + 'INC     '+Reg8[(X and 7)];
        $C8..$CF        : S := S + 'DEC     '+Reg8[(X and 7)];
      else
        S := S + '$'+x.ToHexString(2);
        Inc(unknown);
    //    S := '';
      end;

    end
  else
    begin  // vector mode
      X := BinarySource[Sourceoffset];
      X2 := BinarySource[Sourceoffset+1];
      Addr := (X2 shl 8) OR X;
      Inc(Sourceoffset,2);
      S := SourceOffset.ToHexString(4)+ '     VECTOR:'+Addr.ToHexString(4);
    end;
  If S <> '' then
  begin
    while length(s) < 60 do
      s := s + ' ';
    s := s + ' ;';
    while OldOffset < SourceOffset do
    begin
      S := S + ' ' + BinarySource[OldOffset].ToHexString(2);
      inc(OldOffset);
    end;
    Form1.Memo1.Append(S);
  end;

end;

procedure Disassemble;
var
  s : string;
begin
  If SourceOffset = 0 then
    Sourceoffset := $7800;
  unknown := 0;
  While (SourceOffset < SourceSize) AND (Unknown = 0) do
    Disassemble1;
  If unknown <> 0 then
  begin
    S := unknown.ToString +' unknown bytes';
    Form1.Memo1.Append(S);
  end;
  Form1.EditAddress.Text := SourceOffset.ToHexString(4);
end;

procedure DumpAll;
var
  i : integer;
  s : string;
begin
  Form1.Memo1.Append('--- DUMP ---');
  for i := 0 to SourceSize-1 do
  begin
    s := (i).ToHexString(4)+': '+Ord(BinarySource[i]).ToHexString(2);
    Form1.Memo1.Append(s);
  end;
  s := '--- '+SourceSize.ToString+' Bytes Dumped ---';
  Form1.Memo1.Append(s);
end;

procedure LoadFile(FileName : String);
var
  s : string;
  f : file;
begin
  S := '';
  FillChar(BinarySource,MemSize,0);
  s := 'File Load: '+FileName;
  Form1.Memo1.Append(s);
  Assign(F,FileName);
  Reset(F,1);
  BlockRead(F,BinarySource,MemSize,SourceSize);
  Close(F);
  SourceOffset := 0;
  s := SourceSize.ToString + ' bytes loaded';
  Form1.Memo1.Append(s);
//  DumpAll;
end;

procedure TForm1.MenuOpenClick(Sender: TObject);
begin

end;

procedure TForm1.ValueListEditor1Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Disassemble;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  DumpAll;
end;

procedure TForm1.ButtonLoadLabelsClick(Sender: TObject);
begin
  LabelList.LoadFromFile('labels.txt');
end;

procedure TForm1.ButtonSaveLabelsClick(Sender: TObject);
begin
  LabelList.SaveToFile('labels.txt');
end;

procedure TForm1.EditAddressChange(Sender: TObject);
var
  i : LongInt;
  s : string;
  err : Integer;
begin
  S := '$'+Form1.EditAddress.Text;
  val(s,i,err);
  if err = 0 then
    SourceOffset := i;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FillChar(BinarySource,MemSize,0);
  SourceSize := 0;
  SourceOffset := 0;
end;


procedure TForm1.MenuHelpAboutClick(Sender: TObject);
begin
  ShowMessage('Resource78213 - a NEC uPD78213 disassembler');
end;

procedure TForm1.MenuFileExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.MenuFileOpenClick(Sender: TObject);
begin
  If OpenDialog1.Execute then
  begin
    StatusBar1.Panels[0].Text:='SRC: '+OpenDialog1.FileName;
    LoadFile(OpenDialog1.FileName);
  end
  else
    StatusBar1.Panels[0].Text:='SRC: No File';
  SourceOffset := 0;
end;

procedure TForm1.MenuSaveClick(Sender: TObject);
begin

end;

end.

