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
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private readonly string showPagesPath;

        public MainWindow()
        {
            InitializeComponent();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            string initPage = RelativeToAbsolute("ShowPages\\html\\index.html");

            webControl.Navigate(initPage);
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

        private void webControl_LoadCompleted(object sender, NavigationEventArgs e)
        {
            // 将字符串传递到浏览器页面
            webControl.InvokeScript("setContent", new object[] { "Hello, World!" });
        }
    }
}
