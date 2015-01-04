<%@ Page Language="C#" AutoEventWireup="true" CodeFile="homepagetest.aspx.cs" Inherits="homepagetest" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Arul's Home Page</title>
    <link rel="shortcut icon" type="image/x-icon" href="./favicon/new.ico" />
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <script src="jQuery/jquery.min.js"></script>
    <script src="jQuery/jquery.scrolly.min.js"></script>
    <script src="jQuery/skel.min.js"></script>
    <script src="jQuery/init.js"></script>

    <%--The <noscript> tag defines an alternate content for users that have disabled scripts in their browser or have a browser that doesn't support script.--%>
    <noscript>
        <link rel="stylesheet" href="css/homepage/skel.css" />
        <link rel="stylesheet" href="css/homepage/default.css" />
        <link rel="stylesheet" href="css/homepage/desktop.css" />
    </noscript>
</head>

<body>
    <form id="form1" runat="server">
        <!-- Nav -->
        <nav id="nav">
            <ul class="container">
                <li><a href="sitestatistics/" target="_blank">SiteStatistics</a></li>
                <li><a href="statistics/" target="_blank">Statistics</a></li>
                <li><a href="source/" target="_blank">Source</a></li>
                <li><a href="search/" target="_blank">Search</a></li>
                <li><a href="searchtree/" target="_blank">SearchTree</a></li>
                <li><a href="textview/" target="_blank">TextView</a></li>
                <li><a href="filelist.aspx" target="_blank">FileList</a></li>
                <li><a href="autofile.aspx" target="_blank">AutoFile</a></li>
                <li><a href="images/autoimage.aspx" target="_blank">Images</a></li>
                <li><a href="blog/" target="_blank">Blog</a></li>
            </ul>
        </nav>
        <%--The <article> tag specifies independent, self-contained content.--%>
        <%--An article should make sense on its own and it should be possible to distribute it independently from the rest of the site.--%>
        <div class="wrapper style1 first">
            <article class="container" id="top">
                <div class="row">
                    <div class="4u">
                        <span class="image fit">
                            <img class="rotate" src="images/homepage/Arul-web.jpg" alt="" /></span>
                    </div>
                    <div class="8u">
                        <header>
                            <h1 class="Name_with_Neon"><strong>Welcome to Arulselvan Madhavan's Website</strong>.</h1>
                        </header>
                        <p>This is a website that I am developing as part of Web development course at Northeastern University. I am a first year Computer Science graduate student from India.</p>
                        <p>
                            This course has helped me learn several new technologies like Angular JS,Node Js,Express JS,Jquery,Mongo DB,ASP.NET,ADO.NET, Entity Framework in .NET(ORM),and ofcourse HTML & CSS3.
                            I have performed several experiments on all of these technologies and used several of them in my project. Please feel free to browse through the below links to learn  more about my experiments and projects.
                        </p>
                        <div class="row">
                            <div class="4u  d_icons">
                                <section class="box style1">
                                    <span class="icon featured fa-info"></span>
                                    <a href="blog/" target="_blank"><span data-hover="Blog">Blog</span></a>
                                    <%--<h3>About me</h3>--%>
                                </section>

                            </div>
                            <div class="4u d_icons">
                                <section class="box style1">
                                    <span class="icon featured fa fa-flask"></span>
                                    <a href="story/index.htm?../experiments/story.txt" target="_blank"><span data-hover="Experiments">Experiments</span></a>
                                    <%--<h3>Experiments</h3>--%>
                                </section>
                            </div>
                            <div class="4u d_icons">
                                <section class="box style1">
                                    <span class="icon featured fa-graduation-cap"></span>
                                    <a href="story/index.htm?../project/story.txt"><span data-hover="Projects">Projects</span></a>
                                    <%--<h3>Projects</h3>--%>
                                </section>
                            </div>
                        </div>
                    </div>
                </div>
            </article>
        </div>
    </form>
</body>
</html>
