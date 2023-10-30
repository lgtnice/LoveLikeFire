using CefSharp;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace MainWPF
{
    /// <summary>
    /// MainWindow.xaml 的交互逻辑
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            string initPage = RelativeToAbsolute("ShowPages\\html\\index.html");

            webControl.Address = initPage;
        }

        private void webControl_FrameLoadEnd(object sender, FrameLoadEndEventArgs e)
        {
            webControl.ExecuteScriptAsync("setContent", "Hello, World!");
        }

        internal static string RelativeToAbsolute(string originPath)
        {
            if (System.IO.Path.IsPathRooted(originPath))
            {
                return originPath;
            }

            string dllPath = Assembly.GetExecutingAssembly().Location;
            string dllDir = System.IO.Path.GetDirectoryName(dllPath);
            string finalAbsolutePath = System.IO.Path.Combine(dllDir, originPath);
            return finalAbsolutePath;
        }
    }
}
