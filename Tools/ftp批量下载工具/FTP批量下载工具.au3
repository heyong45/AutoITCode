#NoTrayIcon
#Region ;**** ���������� ACNWrapper_GUI ****
#AutoIt3Wrapper_outfile=D:\ftp�������ع���\FTP�������ع���.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Res_Comment=FTP�ļ��������ع���
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#EndRegion ;**** ���������� ACNWrapper_GUI ****
#Region AutoIt3Wrapper Ԥ�������(���ò���)
;#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%		;�Զ�����Դ��
;#AutoIt3Wrapper_Run_Tidy=                   				;�ű�����
;#AutoIt3Wrapper_Run_Obfuscator=      						;�����Ի�
;#AutoIt3Wrapper_Run_AU3Check= 								;�﷨���
;#AutoIt3Wrapper_Run_Before= 								;����ǰ
;#AutoIt3Wrapper_Run_After=									;���к�
#EndRegion AutoIt3Wrapper Ԥ��������������
#cs �ߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣ�

 Au3 �汾:3.6
 �ű�����: Sonny
	Email: sonny45@126.com
	QQ/TM: 
 �ű��汾: 
 �ű�����: ������FTP�����������ļ�

#ce �ߣߣߣߣߣߣߣߣߣߣߣߣߣߣ߽ű���ʼ�ߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣߣ�
#Include <GuiListView.au3>
#Include <GuiTab.au3>
#include <FTPEx.au3>

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <ListViewConstants.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=d:\ftp�������ع���\form1.kxf
$Form1_1 = GUICreate("FTP�ļ��������ع���", 531, 438, 218, 152)
$Tab1 = GUICtrlCreateTab(1, 0, 529, 417)
$downloadPage = GUICtrlCreateTabItem("����")
$Button1 = GUICtrlCreateButton("����ѡ���ļ�", 320, 376, 91, 25)
$Button2 = GUICtrlCreateButton("ȫ������", 440, 376, 75, 25)
$Label1 = GUICtrlCreateLabel("�����б�", 16, 32, 64, 17)
$ListView_ServerList = GUICtrlCreateListView("���|������|�ļ���|����״̬|���һ������ʱ��", 8, 56, 513, 313, BitOR($GUI_SS_DEFAULT_LISTVIEW,$WS_HSCROLL), BitOR($WS_EX_CLIENTEDGE,$LVS_EX_GRIDLINES,$LVS_EX_CHECKBOXES,$LVS_EX_FULLROWSELECT))
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 50)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 100)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 2, 150)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 3, 70)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 4, 138)
$Button_delete = GUICtrlCreateButton("ɾ��ѡ����", 208, 376, 75, 25)
$Button_Edit = GUICtrlCreateButton("�༭ѡ����", 104, 376, 75, 25)
$configPage = GUICtrlCreateTabItem("����")
$toolConfigGroup = GUICtrlCreateGroup("�������ã�", 9, 240, 513, 169)
$Label6 = GUICtrlCreateLabel("���ش洢·����", 18, 266, 88, 17)
$Input_localPath = GUICtrlCreateInput("", 105, 264, 393, 21)
$Button_pathRest = GUICtrlCreateButton("����·��", 313, 296, 75, 25)
$Button_Save = GUICtrlCreateButton("����", 425, 296, 75, 25)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$addConfigGroup = GUICtrlCreateGroup("�༭FTP��Ϣ��", 9, 32, 513, 201)
$Label2 = GUICtrlCreateLabel("IP��ַ��", 33, 64, 50, 17)
$Input_IPAddress = GUICtrlCreateInput("", 105, 64, 129, 21)
$Label3 = GUICtrlCreateLabel("�˻�����", 33, 101, 52, 17)
$Input_name = GUICtrlCreateInput("", 105, 101, 129, 21)
$Label4 = GUICtrlCreateLabel("�˻����룺", 33, 139, 64, 17)
$Input_password = GUICtrlCreateInput("", 105, 139, 129, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_PASSWORD))
$Label5 = GUICtrlCreateLabel("�ļ�·����", 33, 176, 64, 17)
$Input_remoteFilePath = GUICtrlCreateInput("", 105, 176, 401, 21)
$Button_Add = GUICtrlCreateButton("���/����", 33, 200, 75, 25)
$Button_Reset = GUICtrlCreateButton("����", 161, 200, 75, 25)
$Edit_Notice = GUICtrlCreateEdit("", 256, 48, 249, 113, $ES_WANTRETURN)
GUICtrlSetData(-1, StringFormat("*************** ��ʾ: ****************\r\n\r\n���ͬһ����������Ҫ���ض���ļ���\r\n�����ļ�·����������������е��ļ�·��\r\n����"&Chr(34)&";"&Chr(34)&"(�ֺ�)�ָ\r\n\r\nʾ����\r\n/file1.txt;/config/file2.cfg"))
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")
$StatusBar1 = _GUICtrlStatusBar_Create($Form1_1)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###






Global $configFile = @ScriptDir&"\config.ini"
Global $localSavePath=""

initEnv()
While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $Button_Add
			 addDownloadInfo()
		 Case $Button_Reset
			resetDownloadInfo()
		Case $Button1
			GUICtrlSetState($Button1,$GUI_DISABLE)
			GUICtrlSetState($Button2,$GUI_DISABLE)
			downloadSelectedFile()
			GUICtrlSetState($Button1,$GUI_ENABLE)
			GUICtrlSetState($Button2,$GUI_ENABLE)
		Case $Button2
			GUICtrlSetState($Button1,$GUI_DISABLE)
			GUICtrlSetState($Button2,$GUI_DISABLE)
			downloadAllServerFile()
			GUICtrlSetState($Button1,$GUI_ENABLE)
			GUICtrlSetState($Button2,$GUI_ENABLE)
		Case $Button_delete
			deleteSelectedConfig()
		Case $Button_Edit
			updateFTPServerInfo()
		Case $Button_pathRest
			$localSavePath = IniRead($configFile,"Common","localSavePath","")
			GUICtrlSetData($Input_localPath,$localSavePath)
		Case $Button_Save
			IniWrite($configFile,"Common","localSavePath",GUICtrlRead($Input_localPath))
	EndSwitch
WEnd



Func initEnv()
	;������ʼ��
	If Not FileExists($configFile) Then
		initConfigFile()
	EndIf
	loadConfig()
EndFunc

Func initConfigFile()
	;���������ļ�
	IniWrite($configFile,"Common","localSavePath",@ScriptDir&"\downloads")
EndFunc

Func loadConfig()
	;����������Ϣ��������
	$localSavePath = IniRead($configFile,"Common","localSavePath","")
	GUICtrlSetData($Input_localPath,$localSavePath)
	
	Local $serverList = IniReadSectionNames($configFile)
	If @error Then
		Return
	EndIf
	Local $startNum = 1
	_GUICtrlListView_DeleteAllItems($ListView_ServerList)
	For $i = 1 To $serverList[0]
		Local $item = $serverList[$i]
		If $item == "Common" Then
			ContinueLoop
		EndIf
		Local $reFilePath = IniRead($configFile,$item,"filePath","")
		Local $downloadState = IniRead($configFile,$item,"lastDownloadState","")
		Local $lastDownloadTime = IniRead($configFile,$item,"lastDownloadTime","")
		 GUICtrlCreateListViewItem($startNum & '|' & $item & '|' &$reFilePath& '|' &$downloadState& '|' &$lastDownloadTime, $ListView_ServerList)
		 $startNum += 1
	 Next
	 Sleep(1000)
EndFunc

Func  addDownloadInfo()
	$serverIP = GUICtrlRead($Input_IPAddress)
	$serverName = GUICtrlRead($Input_name)
	$serverPwd = GUICtrlRead($Input_password)
	$serverFilePath = GUICtrlRead($Input_remoteFilePath)
	;todo
	;�ж�IP��ַ�Ƿ�Ϸ�
	;�ж�IP��ַ�������ļ����Ƿ��Ѿ�����
	;�������������Ƿ�����
	Local $operat = "����"
	Local $tabSwitch = True
	IniReadSection($configFile,$serverIP)
	If @error Then
		$operat = "���"
		$tabSwitch = False
	EndIf
	
	IniWrite($configFile,$serverIP,"userName",$serverName)
	IniWrite($configFile,$serverIP,"userPassword",$serverPwd)
	IniWrite($configFile,$serverIP,"filePath",$serverFilePath)
	IniWrite($configFile,$serverIP,"lastDownloadTime","")
	IniWrite($configFile,$serverIP,"lastDownloadState","")
	MsgBox(0,"�ɹ�","��Ϣ"&$operat&"�ɹ���",5,$Form1_1)
	updateStatus($operat&"������"&$serverIP&"�ɹ�")
	resetDownloadInfo()
	GUICtrlSetState($Input_IPAddress,$GUI_ENABLE)
	loadConfig()
	If $tabSwitch Then
		_GUICtrlTab_ClickTab($Tab1, 0)
	EndIf
EndFunc

Func resetDownloadInfo()
	GUICtrlSetData($Input_IPAddress,"")
	GUICtrlSetData($Input_name,"")
	GUICtrlSetData($Input_password,"")             
	GUICtrlSetData($Input_remoteFilePath,"")
EndFunc

Func downloadSelectedFile()
	;����ѡ�еķ������ļ�
	Local $serversCount = _GUICtrlListView_GetItemCount($ListView_ServerList)
	For $i = 0 To $serversCount -1
		If _GUICtrlListView_GetItemChecked($ListView_ServerList, $i) = True Then
			startDownloadProcess($i)
		EndIf
	Next
EndFunc
Func downloadAllServerFile()
	;�������еķ������ļ�
	Local $serversCount = _GUICtrlListView_GetItemCount($ListView_ServerList)
	
	For $i = 0 To $serversCount -1
		startDownloadProcess($i)
	Next
EndFunc

Func startDownloadProcess($i)
	Local $serIP = _GUICtrlListView_GetItemText($ListView_ServerList,$i,1)
	Local $serFile = _GUICtrlListView_GetItemText($ListView_ServerList,$i,2)
	Local $state = "�ɹ�"
	Local $timeStr = @YEAR&'-'&@MON&'-'&@MDAY&" "&@HOUR&":"&@MIN&":"&@SEC
	If 0 <> ftpDownloadFile($serIP,$serFile) Then
		$state = "ʧ��"
	EndIf
	_GUICtrlListView_SetItemText($ListView_ServerList,$i,$state,3)
	_GUICtrlListView_SetItemText($ListView_ServerList,$i,$timeStr,4)
	IniWrite($configFile,$serIP,"lastDownloadState",$state)
	IniWrite($configFile,$serIP,"lastDownloadTime",$timeStr)
EndFunc

Func deleteSelectedConfig()
	$userChocie=MsgBox(1,"ע��","��ȷ���Ƿ�ɾ����ѡ�����")
	If 2 == $userChocie Then
		Return
	EndIf
	
	Local $serversCount = _GUICtrlListView_GetItemCount($ListView_ServerList)
	For $i = 0 To $serversCount -1
		If _GUICtrlListView_GetItemChecked($ListView_ServerList, $i) = True Then
			Local $serIP = _GUICtrlListView_GetItemText($ListView_ServerList,$i,1)
			IniDelete($configFile,$serIP)
		EndIf
	Next
	loadConfig()
EndFunc

Func loadServerInfo($server)
	;���ض�Ӧ�ķ�������Ϣ
	Local $userName = IniRead($configFile,$server,"userName","")
	Local $userPwd = IniRead($configFile,$server,"userPassword","")
	Local $filePath= IniRead($configFile,$server,"filePath","")
	GUICtrlSetData($Input_IPAddress,$server)
	GUICtrlSetData($Input_name,$userName)
	GUICtrlSetData($Input_password,$userPwd)
	GUICtrlSetData($Input_remoteFilePath,$filePath)
	_GUICtrlTab_ClickTab($Tab1, 1)
	GUICtrlSetState($Input_remoteFilePath,$GUI_FOCUS)
	GUICtrlSetState($Input_IPAddress,$GUI_DISABLE)

EndFunc

Func updateFTPServerInfo()
	;����FTP��Ϣ
	Local $serversCount = _GUICtrlListView_GetItemCount($ListView_ServerList)
	
	For $i = 0 To $serversCount -1
		If True == _GUICtrlListView_GetItemFocused($ListView_ServerList, $i) Then
			Local $serIP = _GUICtrlListView_GetItemText($ListView_ServerList,$i,1)
			loadServerInfo($serIP)
			return
		EndIf
	Next
	MsgBox(0,"��ʾ","��ǰû��ѡ���",5,$Form1_1)
EndFunc

Func ftpDownloadFile($ftpServerIP,$remoteFile)
	Local $result = 0
	If "" == $localSavePath Then
		MsgBox(0,"��ʾ","�������ñ��ر����ַ��")
		updateStatus("�������ñ��ر����ַ��")
	EndIf
	If Not FileExists($localSavePath) Then
		DirCreate($localSavePath)
	EndIf
	Local $ftpUserName = IniRead($configFile,$ftpServerIP,"userName","")
	Local $ftpPWD = IniRead($configFile,$ftpServerIP,"userPassword","")
	Local $ftpRemoteFile = IniRead($configFile,$ftpServerIP,"filePath","")
	Local $ftpOpen = _FTP_Open('MyFTP Client')
	updateStatus("�������ӷ�����"&$ftpServerIP&"...")
	Local $Conn = _FTP_Connect($ftpOpen, $ftpServerIP, $ftpUserName, $ftpPWD)
	
	If @error Then
		;connect to ftp server failed.
		updateStatus("���ӷ�����"&$ftpServerIP&"ʧ��!")
		Sleep(1000)
		Return 1
	EndIf
	_FTP_Command($Conn, "bin" )
	Local $fileList = StringSplit($ftpRemoteFile,';')
	For $i = 1 To $fileList[0]
		Local $fileName = $fileList[$i]
		Local $strTmp = StringSplit($fileName,'/',1)
		Local $localFileName = $strTmp[$strTmp[0]]
		updateStatus("�ӷ�����"&$ftpServerIP&"�����ļ�"&$fileName&"...")
		 _FTP_FileGet($Conn, $fileName, $localSavePath&"/"&@YEAR&@MON&@MDAY&"_"&$ftpServerIP&"_"&$localFileName)
		If @error Then
			updateStatus("�ӷ�����"&$ftpServerIP&"�����ļ�"&$fileName&"ʧ��!")
			$result =  1
		Else
			updateStatus("�ӷ�����"&$ftpServerIP&"�����ļ�"&$fileName&"�ɹ�!")
		EndIf
	Next
	Local $Ftpc = _FTP_Close($ftpOpen)
	Return $result
EndFunc

Func updateStatus($message)
	;����״̬��Ϣ��״̬��
	_GUICtrlStatusBar_SetText($StatusBar1,$message)
EndFunc

