<%@ Page Language="C#" AutoEventWireup="true" CodeFile="exp28-debugjquery.aspx.cs" Inherits="experiments_project_experiments_exp28_debugjquery" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link  href="css/crophome/listview-grid.css" rel="stylesheet"/>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
</head>
<body>

<div data-role="page" data-theme="a" id="demo-page" class="my-page">
    <div data-role="header">
        <h1>News</h1>
    </div><!-- /header -->
    
    <div data-role="content">
        <ul data-role="listview" data-inset="true">
            <li>
                <a href="#">
                    <img src="http://view.jquerymobile.com/master/demos/_assets/img/nexus_7.png" />
                    <h2>iOS 6.1</h2>
                    <p>Apple released iOS 6.1</p>
                    <p class="ui-li-aside">iOS</p>
                </a>
            </li>
            <li>
                <a href="#">
                    <img src="http://view.jquerymobile.com/master/demos/_assets/img/nexus_7.png" />
                    <h2>BlackBerry 10</h2>
                    <p>BlackBerry launched the Z10 and Q10 with the new BB10 OS</p>
                    <p class="ui-li-aside">BlackBerry</p>
                </a>
            </li>
            <li>
                <a href="#">
                    <img src="http://view.jquerymobile.com/master/demos/_assets/img/nexus_7.png" />
                    <h2>WP 7.8</h2>
                    <p>Nokia rolls out WP 7.8 to Lumia 800</p>
                    <p class="ui-li-aside">Windows Phone</p>
                </a>
            </li>
        </ul>
    </div><!-- /content -->
    <div data-role="footer" data-theme="none">
        <h3>Powered by: <a href="http://shreerangpatwardhan.blogspot.com">Spatial Unlimited</a></h3>
    </div><!-- /footer -->
    
</div><!-- /page -->
</body>
</html>
