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
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuHelpAbout: TMenuItem;
    MenuFileOpen: TMenuItem;
    MenuFileExit: TMenuItem;
    Separator1: TMenuItem;
    OpenDialog1: TOpenDialog;
    StatusBar1: TStatusBar;
    LabelList: TValueListEditor;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuHelpAboutClick(Sender: TObject);
    procedure MenuFileExitClick(Sender: TObject);
    procedure MenuFileOpenClick(Sender: TObject);
    procedure MenuOpenClick(Sender: TObject);
    procedure ValueListEditor1Click(Sender: TObject);
  private

  public

  end;

  tMode = (Vector,Instruction);

const
  MemSize = 65536;
  Reg4 : Array[0..3] of String = ('AX','BC','DE','HL');
  Reg8 : Array[0..7] Of String = ('X','A','C','B','E','D','L','H');
  Mem1 : Array[0..1] of String = ('[DE]','[HL]');

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
        $05             : begin
                            Case Y of
                              $E2 : S := S + 'MOVW    AX,[DE+'+Y.ToHexString(2)+']';
                              $E3 : S := S + 'MOVW    AX,[HL+'+Y.ToHexString(2)+']';
                              $E6 : S := S + 'MOVW    [DE+'+Y.ToHexString(2)+'],AX';
                              $E7 : S := S + 'MOVW    [HL+'+Y.ToHexString(2)+'],AX';
                            else
                              S := S + 'Unknown MOVW variant';
                              Inc(Unknown);
                            end;
                          end;
        $0B             : S := S + 'MOVW    [FF'
                                 + Y.ToHexString(2)
                                 +'],#'+ OpWord.ToHexString(4);
        $60,$62,$64,$66 : S := S + 'MOVW    '+Reg4[(X shr 1) AND 3]+',#'+OpWord.ToHexString(4);
        $8A             : begin
                            x2 := y;
                            S := S + 'SUB     '+Reg8[(x2 shr 4) AND 7]+','+Reg8[x2 AND 7];
                          end;
        $B8..$BF        : S := S + 'MOV     '+Reg8[(X and 7)]+','+Y.ToHexString(2)+'h';

    (*
        $00 		: S := S + 'NOP';
        $03 		: S := S + 'ADD     A,#'+Y.ToHexString(2)+'h';
        $04,$24,$44,$64 	: S := S + 'JMP     '+ NiceAddress(((X SHR 5) SHL 8) + Y);
        $07                 : S := S + 'DEC     A';
        $08..$0a 		: S := S + 'IN      A,P' + (X and 3).ToHexString(1);
        $10..$11  		: S := S + 'INC     @R'  +(X and $01).ToHexString(1);
        $13 		: S := S + 'ADDC    A,#'+Y.ToHexString(2)+'h';
        $14,$34,$54,$74 	: s := S + 'CALL    '+ NiceAddress(((X SHR 5) SHL 8) + Y);
        $16 		: S := S + 'JTF     '+ NiceAddress(((SourceOffset-1) AND $ff00) OR Y);
        $17                 : S := S + 'INC     A';
        $18..$1f  		: S := S + 'INC     R'   +(X and $07).ToHexString(1);

        $23 		: S := S + 'MOV     A,#'+Y.ToHexString(2)+'h';
        $27                 : S := S + 'CLR     A';
        $28..$2f  		: S := S + 'XCH     A,R'   +(X and $07).ToHexString(1);
        $37                 : S := S + 'CMPL    A';

        $39                 : S := S + 'OUTL    P1,A';
        $3a                 : S := S + 'OUTL    P2,A';

        $40..$41  		: S := S + 'ORL     A,@R'  +(X and $01).ToHexString(1);
        $42                 : S := S + 'MOV     A,T';
        $43 		: S := S + 'ORL     A,#'+Y.ToHexString(2)+'h';
        $45                 : S := S + 'STRT    CNT';
        $46 		: S := S + 'JNT1    '+ NiceAddress(((SourceOffset-1) AND $ff00) OR Y);
        $47                 : S := S + 'SWAP    A';
        $48..$4f  		: S := S + 'ORL     A,R'   +(X and $07).ToHexString(1);
        $50..$51  		: S := S + 'ANL     A,@R'  +(X and $01).ToHexString(1);
        $53 		: S := S + 'ANL     A,#'+Y.ToHexString(2)+'h';
        $55                 : S := S + 'STRT    T';
        $56 		: S := S + 'JT1     '+ NiceAddress(((SourceOffset-1) AND $ff00) OR Y);
        $57                 : S := S + 'DA      A';
        $58..$5f  		: S := S + 'ANL     A,R'   +(X and $07).ToHexString(1);
        $60..$61  		: S := S + 'ADD     A,@R'  +(X and $01).ToHexString(1);
        $62                 : S := S + 'MOV     T,A';

        $65                 : S := S + 'STOP    TCNT';
        $67                 : S := S + 'RRC     A';

        $68..$6f  		: S := S + 'ADD     A,R'   +(X and $07).ToHexString(1);
        $70..$71  		: S := S + 'ADDC    A,@R' +(X and $01).ToHexString(1);
        $77                 : S := S + 'RR      A';
        $78..$7f  		: S := S + 'ADDC    A,R'  +(X and $07).ToHexString(1);
        $83                 : S := S + 'RET';

        $90                 : S := S + 'OUTL    P0,A';
        $96 		: S := S + 'JNZ     '+ NiceAddress(((SourceOffset-1) AND $ff00) OR Y);
        $97                 : S := S + 'CLR     C';
        $9c..$9f  		: S := S + 'ANLD    P' + ((X and $03)+4).ToHexString(1) + ',A';
        $a0..$a1            : S := S + 'MOV     @R'+(X AND $01).ToHexString(1)+',A';
        $a7                 : S := S + 'CPL     C';
        $a8..$af  		: S := S + 'MOV     R'+(X and $07).ToHexString(1)+',A';
        $b0..$b1            : S := S + 'MOV     @R'+(X and $01).ToHexString(1)+',#'+Y.ToHexString(2)+'h';
        $b8..$bf  		: S := S + 'MOV     R'+(X AND $07).ToHexString(1)+',#'+Y.ToHexString(2)+'h';
        $c6 		: S := S + 'JZ      '+ NiceAddress(((SourceOffset-1) AND $ff00) OR Y);
        $d0..$d1  		: S := S + 'XRL     A,@R'+(X AND $01).ToHexString(1);
        $d3                 : S := S + 'XRL     A,#'+Y.ToHexString(2)+'h';
        $d8..$df  		: S := S + 'XRL     A,R'+(X and $07).ToHexString(1);
        $e6 		: S := S + 'JNC     '+ NiceAddress(((SourceOffset-1) AND $ff00) OR Y);
        $e7                 : S := S + 'RL      A';
        $e8..$ef  		: S := S + 'DJNZ    R'+(X and $07).ToHexString(1)+','+ NiceAddress(((SourceOffset-1) AND $ff00) OR Y);
        $f0..$f1  		: S := S + 'MOV     A,@R'+(X AND $01).ToHexString(1);
        $f6 		: S := S + 'JC      '+ NiceAddress(((SourceOffset-1) AND $ff00) OR Y);
        $f7                 : S := S + 'RLC     A';
        $f8..$ff  		: S := S + 'MOV     A,R' +(X and $07).ToHexString(1);
    *)
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
  Sourceoffset := $78BD;
  unknown := 0;
  While (SourceOffset < SourceSize) AND (Unknown = 0) do
    Disassemble1;
  If unknown <> 0 then
  begin
    S := unknown.ToString +' unknown bytes';
    Form1.Memo1.Append(S);
  end;
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
end;

end.

