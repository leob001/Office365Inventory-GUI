Function Open-Help {
	$rs=[RunspaceFactory]::CreateRunspace()
	$rs.ApartmentState = "STA"
	$rs.ThreadOptions = "ReuseThread"
	$rs.Open()
	$ps = [PowerShell]::Create()
	$ps.Runspace = $rs
    $ps.Runspace.SessionStateProxy.SetVariable("pwd",$pwd)
	[void]$ps.AddScript({ 
[xml]$xaml = @"
<Window
    xmlns='http://schemas.microsoft.com/winfx/2006/xaml/presentation'
    xmlns:x='http://schemas.microsoft.com/winfx/2006/xaml'
    x:Name='Window' Title='Help For PowerShell Office 365 Inventory GUI' Height = '600' Width = '800' WindowStartupLocation = 'CenterScreen' 
    ResizeMode = 'NoResize' ShowInTaskbar = 'True' >    
    <Window.Background>
        <LinearGradientBrush StartPoint='0,0' EndPoint='0,1'>
            <LinearGradientBrush.GradientStops> <GradientStop Color='#C4CBD8' Offset='0' /> <GradientStop Color='#E6EAF5' Offset='0.2' /> 
            <GradientStop Color='#CFD7E2' Offset='0.9' /> <GradientStop Color='#C4CBD8' Offset='1' /> </LinearGradientBrush.GradientStops>
        </LinearGradientBrush>
    </Window.Background>    
    <Grid>
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width ='30*'> </ColumnDefinition>
            <ColumnDefinition Width ='Auto'> </ColumnDefinition>
            <ColumnDefinition Width ='75*'> </ColumnDefinition>
        </Grid.ColumnDefinitions>
        <TreeView Name = 'HelpTree' FontSize='10pt'>
            <TreeViewItem x:Name = 'RequirementsView' Header = 'Requirements' />  
			<TreeViewItem Header = 'Connect to Office 365' />
			<TreeViewItem Header = 'Actions' />
			<TreeViewItem Header = 'Reporting' />
			<TreeViewItem Header = 'Keyboard Shortcuts' /> 
        </TreeView>
        <GridSplitter Grid.Column='1' Width='6' HorizontalAlignment = 'Center' VerticalAlignment = 'Stretch'>
        </GridSplitter>
        <Frame Name = 'Frame' Grid.Column = '2'>
            <Frame.Content>
            <Page Title = "Home">
                <FlowDocumentReader>
                    <FlowDocument>
                        <Paragraph FontSize = "20">
                            <Bold> PowerShell Office 365 Inventory GUI </Bold>
                        </Paragraph>
						<Paragraph>
                            Please click on one of the links on the left to view the various help items.
                        </Paragraph>
                        <Paragraph> <Image Source = '$pwd\HelpFiles\Images\FrontWindow.png' /> </Paragraph>
                    </FlowDocument>
                </FlowDocumentReader>
            </Page>
            </Frame.Content>
        </Frame>
    </Grid>
</Window>

"@
#Load XAML
$reader=(New-Object System.Xml.XmlNodeReader $xaml)
$HelpWindow=[Windows.Markup.XamlReader]::Load( $reader )

#Requirements Help
[xml]$data = @"
<Page
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title = "Requirements">    
    <FlowDocumentReader>
        <FlowDocument>
            <Paragraph FontSize = "18" TextAlignment="Center">   
                <Bold> Requirements for the Office 365 GUI </Bold>
            </Paragraph>       
			<Paragraph>
				You will need the below requirements before you can use this tool:
			</Paragraph>
			<List MarkerStyle="decimal">
				<ListItem><Paragraph>At least Exchange, SharePoint and User administrator permissions in Office 365. Being Global Administrator will certainly do the job.</Paragraph></ListItem>
				<ListItem>
					<Paragraph>
						Microsoft Online Services Sign-In Assistant for IT Professionals RTW.
						You can download at <Hyperlink x:Name = 'SignInAssistant'> https://www.microsoft.com/en-us/download/details.aspx?id=41950 </Hyperlink>
					</Paragraph>
				</ListItem>
				<ListItem>
					<Paragraph>
						Azure Active Directory PowerShell V1.
						You can download at <Hyperlink x:Name = 'AADPS'> http://connect.microsoft.com/site1164/Downloads/DownloadDetails.aspx?DownloadID=59185 </Hyperlink>
					</Paragraph>
				</ListItem>
				<ListItem>
					<Paragraph>
						SharePoint Online Management Shell.
						You can download at <Hyperlink x:Name = 'SPOnline'> https://www.microsoft.com/en-us/download/details.aspx?id=35588 </Hyperlink>
					</Paragraph>
				</ListItem>
			</List>
			<Paragraph>
				More information regarding connecting to Office 365 at <Hyperlink x:Name = 'O365'> https://technet.microsoft.com/en-us/library/dn568015.aspx </Hyperlink>
			</Paragraph>
        </FlowDocument>
    </FlowDocumentReader>
</Page>
"@
$reader=(New-Object System.Xml.XmlNodeReader $data)
$Requirements=[Windows.Markup.XamlReader]::Load( $reader )

#InstallPatches Help
[xml]$data = @"
<Page
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title = "Connect to Office 365">
    <FlowDocumentReader ViewingMode = 'Scroll'>
        <FlowDocument>
            <Paragraph FontSize = "18" TextAlignment="Center">   
                <Bold> Connect to Office 365 </Bold>
            </Paragraph>
            <Paragraph>
                Before you can begin you first need to connect to Office 365.
            </Paragraph>   
			<Paragraph> 
				<Image Source = '$pwd\HelpFiles\Images\Connect1.png' />
			</Paragraph>
			<Paragraph>
                Next login with your credentials
            </Paragraph>   
			<Paragraph> 
				<Image Source = '$pwd\HelpFiles\Images\Connect2.png' />
			</Paragraph>			
			<Paragraph>
                Press OK and you should see that all three bullits on the homepage are green
            </Paragraph> 
			<Paragraph> 
				<Image Source = '$pwd\HelpFiles\Images\Connect3.png' />
			</Paragraph>			
        </FlowDocument>
    </FlowDocumentReader>
</Page>
"@
$reader=(New-Object System.Xml.XmlNodeReader $data)
$ConnecttoOffice365=[Windows.Markup.XamlReader]::Load( $reader )

#ReportingPatches Help
[xml]$data = @"
<Page
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title = "Reporting">    
	<FlowDocumentReader ViewingMode = 'Scroll'>
        <FlowDocument>
            <Paragraph FontSize = "18" TextAlignment="Center">   
                <Bold> Reporting </Bold>
            </Paragraph>
            <Paragraph>
                You can at any time create a .csv or .html of the contents in the listview on the selected tab or a .html file of everything.
            </Paragraph>   
            <Paragraph>
                The output from the .csv will look like the below
			</Paragraph> 
			<Paragraph>
				<Image Source = '$pwd\HelpFiles\Images\report1.png' />
            </Paragraph>  
            <Paragraph>
                The output from the .html will look like the below
			</Paragraph>
            <Paragraph>
				<Image Source = '$pwd\HelpFiles\Images\report2.png' />
            </Paragraph>   
            <Paragraph>
                The output from the full .html will look like the below
			</Paragraph>
            <Paragraph>
				<Image Source = '$pwd\HelpFiles\Images\report3.png' />
            </Paragraph>  			
        </FlowDocument>
    </FlowDocumentReader>
</Page>
"@
$reader=(New-Object System.Xml.XmlNodeReader $data)
$Reports=[Windows.Markup.XamlReader]::Load( $reader )

#Actions Help
[xml]$data = @"
<Page
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title = "Actions">    
	<FlowDocumentReader ViewingMode = 'Scroll'>
        <FlowDocument>
            <Paragraph FontSize = "18" TextAlignment="Center">   
                <Bold> Actions </Bold>
            </Paragraph>
            <List>
                <ListItem>
					<Paragraph> 
						<Bold><Image Source = '$pwd\HelpFiles\Images\Start.ico' Height = '16' Width = '16' />: Run 1 action</Bold>
					</Paragraph>
					<Paragraph>
						This action will run the specified action on the specific tab. For example shows all AAD users in the AAD tab.
					</Paragraph>
				</ListItem>
                <ListItem>
					<Paragraph> 
						<Bold><Image Source = '$pwd\HelpFiles\Images\StartAll.ico' Height = '16' Width = '16' />: Run all action</Bold>
					</Paragraph>
					<Paragraph>
						This action will run all available actions.
					</Paragraph>
				</ListItem>
                <ListItem>
					<Paragraph> 
						<Bold>View actions that have been run:</Bold>
					</Paragraph>
					<Paragraph>
						You can view on the homepage which type of information already has been requested.
					</Paragraph>
					<Paragraph>
						<Image Source = '$pwd\HelpFiles\Images\FrontWindow2.png' />
					</Paragraph>					
				</ListItem>			
            </List>           
        </FlowDocument>
    </FlowDocumentReader>
</Page>
"@
$reader=(New-Object System.Xml.XmlNodeReader $data)
$Actions=[Windows.Markup.XamlReader]::Load( $reader )

#Keyboard Shortcuts Help
[xml]$data = @"
<Page
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title = "Keyboard Shortcuts">    
    <FlowDocumentReader>
        <FlowDocument>
            <Paragraph FontSize = "18" TextAlignment="Center">   
                <Bold> List of Keyboard Shortcuts </Bold>
            </Paragraph>
            <List>
                <ListItem><Paragraph> <Bold>F1:</Bold> Display Help </Paragraph></ListItem>
				<ListItem><Paragraph> <Bold>F4:</Bold> Connect to Office 365.</Paragraph></ListItem>
                <ListItem><Paragraph> <Bold>F5:</Bold> Run the selected command.</Paragraph></ListItem>
				<ListItem><Paragraph> <Bold>F6:</Bold> Run all commands.</Paragraph></ListItem>
                <ListItem><Paragraph> <Bold>F8:</Bold> Run a select report to generate </Paragraph></ListItem>
            </List>
        </FlowDocument>
    </FlowDocumentReader>
</Page>
"@
$reader=(New-Object System.Xml.XmlNodeReader $data)
$KeyboardShortcuts=[Windows.Markup.XamlReader]::Load( $reader )

#Connect to all controls
$AzureADPreview = $Requirements.FindName("AzureADPreview")
$HelpTree = $HelpWindow.FindName("HelpTree")
$Frame = $HelpWindow.FindName("Frame")
$RequirementsView = $HelpWindow.FindName("RequirementsView")

##Events
#HelpTree event
$HelpTree.Add_SelectedItemChanged({
    Switch ($This.SelectedItem.Header) {
        "Requirements" {
            $Frame.Content = $Requirements        
            }
        "Connect to Office 365" {
            $Frame.Content = $ConnecttoOffice365        
            }
        "Actions" {
            $Frame.Content = $Actions
            }			
        "Reporting" {
            $Frame.Content = $Reports
            }
        "Keyboard Shortcuts" {
            $Frame.Content = $KeyboardShortcuts
			}  
		}
    })
	
#PsexecLink Event
$SignInAssistant.Add_Click({
    Start-Process "https://www.microsoft.com/en-us/download/details.aspx?id=41950"
    })

$AADPS.Add_Click({
    Start-Process "http://connect.microsoft.com/site1164/Downloads/DownloadDetails.aspx?DownloadID=59185"
    })
	
$SPOnline.Add_Click({
    Start-Process "https://www.microsoft.com/en-us/download/details.aspx?id=35588"
    })
	
$O365.Add_Click({
    Start-Process "https://technet.microsoft.com/en-us/library/dn568015.aspx"
    })

[void]$HelpWindow.showDialog()

}).BeginInvoke()
}