#NoTrayIcon
#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_outfile=D:\ftp批量下载工具\FTP批量下载工具.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Res_Comment=FTP文件批量下载工具
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#Region AutoIt3Wrapper 预编译参数(常用参数)
;#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%		;自定义资源段
;#AutoIt3Wrapper_Run_Tidy=                   				;脚本整理
;#AutoIt3Wrapper_Run_Obfuscator=      						;代码迷惑
;#AutoIt3Wrapper_Run_AU3Check= 								;语法检查
;#AutoIt3Wrapper_Run_Before= 								;运行前
;#AutoIt3Wrapper_Run_After=									;运行后
#EndRegion AutoIt3Wrapper 预编译参数设置完成
#cs ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿

 Au3 版本:3.6
 脚本作者: Sonny
	Email: sonny45@126.com
	QQ/TM: 
 脚本版本: 
 脚本功能: 批量从FTP服务器下载文件

#ce ＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿脚本开始＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
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
#Region ### START Koda GUI section ### Form=d:\ftp批量下载工具\form1.kxf
$Form1_1 = GUICreate("FTP文件批量下载工具", 531, 438, 218, 152)
$Tab1 = GUICtrlCreateTab(1, 0, 529, 417)
$downloadPage = GUICtrlCreateTabItem("下载")
$Button1 = GUICtrlCreateButton("下载选中文件", 320, 376, 91, 25)
$Button2 = GUICtrlCreateButton("全部下载", 440, 376, 75, 25)
$Label1 = GUICtrlCreateLabel("下载列表：", 16, 32, 64, 17)
$ListView_ServerList = GUICtrlCreateListView("编号|服务器|文件名|下载状态|最后一次下载时间", 8, 56, 513, 313, BitOR($GUI_SS_DEFAULT_LISTVIEW,$WS_HSCROLL), BitOR($WS_EX_CLIENTEDGE,$LVS_EX_GRIDLINES,$LVS_EX_CHECKBOXES,$LVS_EX_FULLROWSELECT))
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 50)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 100)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 2, 150)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 3, 70)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 4, 138)
$Button_delete = GUICtrlCreateButton("删除选中项", 208, 376, 75, 25)
$Button_Edit = GUICtrlCreateButton("编辑选中项", 104, 376, 75, 25)
$configPage = GUICtrlCreateTabItem("配置")
$toolConfigGroup = GUICtrlCreateGroup("工具配置：", 9, 240, 513, 169)
$Label6 = GUICtrlCreateLabel("本地存储路径：", 18, 266, 88, 17)
$Input_localPath = GUICtrlCreateInput("", 105, 264, 393, 21)
$Button_pathRest = GUICtrlCreateButton("重置路径", 313, 296, 75, 25)
$Button_Save = GUICtrlCreateButton("保存", 425, 296, 75, 25)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$addConfigGroup = GUICtrlCreateGroup("编辑FTP信息：", 9, 32, 513, 201)
$Label2 = GUICtrlCreateLabel("IP地址：", 33, 64, 50, 17)
$Input_IPAddress = GUICtrlCreateInput("", 105, 64, 129, 21)
$Label3 = GUICtrlCreateLabel("账户名：", 33, 101, 52, 17)
$Input_name = GUICtrlCreateInput("", 105, 101, 129, 21)
$Label4 = GUICtrlCreateLabel("账户密码：", 33, 139, 64, 17)
$Input_password = GUICtrlCreateInput("", 105, 139, 129, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_PASSWORD))
$Label5 = GUICtrlCreateLabel("文件路径：", 33, 176, 64, 17)
$Input_remoteFilePath = GUICtrlCreateInput("", 105, 176, 401, 21)
$Button_Add = GUICtrlCreateButton("添加/更新", 33, 200, 75, 25)
$Button_Reset = GUICtrlCreateButton("重置", 161, 200, 75, 25)
$Edit_Notice = GUICtrlCreateEdit("", 256, 48, 249, 113, $ES_WANTRETURN)
GUICtrlSetData(-1, StringFormat("*************** 提示: ****************\r\n\r\n如果同一个服务器需要下载多个文件，\r\n请在文件路径输入框中输入所有的文件路径\r\n并以"&Chr(34)&";"&Chr(34)&"(分号)分割。\r\n\r\n示例：\r\n/file1.txt;/config/file2.cfg"))
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
	;环境初始化
	If Not FileExists($configFile) Then
		initConfigFile()
	EndIf
	loadConfig()
EndFunc

Func initConfigFile()
	;创建配置文件
	IniWrite($configFile,"Common","localSavePath",@ScriptDir&"\downloads")
EndFunc

Func loadConfig()
	;加载配置信息到界面中
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
	;判断IP地址是否合法
	;判断IP地址在配置文件中是否已经存在
	;检查服务器连接是否正常
	Local $operat = "更新"
	Local $tabSwitch = True
	IniReadSection($configFile,$serverIP)
	If @error Then
		$operat = "添加"
		$tabSwitch = False
	EndIf
	
	IniWrite($configFile,$serverIP,"userName",$serverName)
	IniWrite($configFile,$serverIP,"userPassword",$serverPwd)
	IniWrite($configFile,$serverIP,"filePath",$serverFilePath)
	IniWrite($configFile,$serverIP,"lastDownloadTime","")
	IniWrite($configFile,$serverIP,"lastDownloadState","")
	MsgBox(0,"成功","信息"&$operat&"成功。",5,$Form1_1)
	updateStatus($operat&"服务器"&$serverIP&"成功")
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
	;下载选中的服务器文件
	Local $serversCount = _GUICtrlListView_GetItemCount($ListView_ServerList)
	For $i = 0 To $serversCount -1
		If _GUICtrlListView_GetItemChecked($ListView_ServerList, $i) = True Then
			startDownloadProcess($i)
		EndIf
	Next
EndFunc
Func downloadAllServerFile()
	;下载所有的服务器文件
	Local $serversCount = _GUICtrlListView_GetItemCount($ListView_ServerList)
	
	For $i = 0 To $serversCount -1
		startDownloadProcess($i)
	Next
EndFunc

Func startDownloadProcess($i)
	Local $serIP = _GUICtrlListView_GetItemText($ListView_ServerList,$i,1)
	Local $serFile = _GUICtrlListView_GetItemText($ListView_ServerList,$i,2)
	Local $state = "成功"
	Local $timeStr = @YEAR&'-'&@MON&'-'&@MDAY&" "&@HOUR&":"&@MIN&":"&@SEC
	If 0 <> ftpDownloadFile($serIP,$serFile) Then
		$state = "失败"
	EndIf
	_GUICtrlListView_SetItemText($ListView_ServerList,$i,$state,3)
	_GUICtrlListView_SetItemText($ListView_ServerList,$i,$timeStr,4)
	IniWrite($configFile,$serIP,"lastDownloadState",$state)
	IniWrite($configFile,$serIP,"lastDownloadTime",$timeStr)
EndFunc

Func deleteSelectedConfig()
	$userChocie=MsgBox(1,"注意","请确认是否删除已选配置项？")
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
	;加载对应的服务器信息
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
	;更新FTP信息
	Local $serversCount = _GUICtrlListView_GetItemCount($ListView_ServerList)
	
	For $i = 0 To $serversCount -1
		If True == _GUICtrlListView_GetItemFocused($ListView_ServerList, $i) Then
			Local $serIP = _GUICtrlListView_GetItemText($ListView_ServerList,$i,1)
			loadServerInfo($serIP)
			return
		EndIf
	Next
	MsgBox(0,"提示","当前没有选中项。",5,$Form1_1)
EndFunc

Func ftpDownloadFile($ftpServerIP,$remoteFile)
	Local $result = 0
	If "" == $localSavePath Then
		MsgBox(0,"提示","请先设置本地保存地址。")
		updateStatus("请先设置本地保存地址。")
	EndIf
	If Not FileExists($localSavePath) Then
		DirCreate($localSavePath)
	EndIf
	Local $ftpUserName = IniRead($configFile,$ftpServerIP,"userName","")
	Local $ftpPWD = IniRead($configFile,$ftpServerIP,"userPassword","")
	Local $ftpRemoteFile = IniRead($configFile,$ftpServerIP,"filePath","")
	Local $ftpOpen = _FTP_Open('MyFTP Client')
	updateStatus("尝试连接服务器"&$ftpServerIP&"...")
	Local $Conn = _FTP_Connect($ftpOpen, $ftpServerIP, $ftpUserName, $ftpPWD)
	
	If @error Then
		;connect to ftp server failed.
		updateStatus("连接服务器"&$ftpServerIP&"失败!")
		Sleep(1000)
		Return 1
	EndIf
	_FTP_Command($Conn, "bin" )
	Local $fileList = StringSplit($ftpRemoteFile,';')
	For $i = 1 To $fileList[0]
		Local $fileName = $fileList[$i]
		Local $strTmp = StringSplit($fileName,'/',1)
		Local $localFileName = $strTmp[$strTmp[0]]
		updateStatus("从服务器"&$ftpServerIP&"下载文件"&$fileName&"...")
		 _FTP_FileGet($Conn, $fileName, $localSavePath&"/"&@YEAR&@MON&@MDAY&"_"&$ftpServerIP&"_"&$localFileName)
		If @error Then
			updateStatus("从服务器"&$ftpServerIP&"下载文件"&$fileName&"失败!")
			$result =  1
		Else
			updateStatus("从服务器"&$ftpServerIP&"下载文件"&$fileName&"成功!")
		EndIf
	Next
	Local $Ftpc = _FTP_Close($ftpOpen)
	Return $result
EndFunc

Func updateStatus($message)
	;更新状态信息到状态栏
	_GUICtrlStatusBar_SetText($StatusBar1,$message)
EndFunc

