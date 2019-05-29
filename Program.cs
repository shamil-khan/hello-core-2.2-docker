using System;
using System.Runtime.InteropServices;
using System.IO;
using System.Text;
using static System.Console;

namespace HelloCore
{
    public static class Program
    {
        public static void Main(string[] args)
        {
            var defaultMessage = "Hello from .NET Core!";
            var bot = GetBot();
            var (message, withColor) = ParseArgs(args);
            var output = message == string.Empty ? $"    {defaultMessage}{bot}" : $"    {message}{bot}";

            if (withColor)
            {
                ConsoleUtils.PrintStringWithRandomColor(output);
            }
            else
            {
                WriteLine(output);
            }

            WriteLine("**Environment**");
            WriteLine($"Platform: .NET Core");
            WriteLine($"OS: {RuntimeInformation.OSDescription}");
            WriteLine();

            var counter = 0;
            var max = args.Length != 0 ? Convert.ToInt32(args[0]) : -1;
            while (max == -1 || counter < max)
            {
                counter++;
                Console.WriteLine($"Counter: {counter}");
                System.Threading.Tasks.Task.Delay(1000).Wait();
            }
        }

        private static (string, bool) ParseArgs(string[] args)
        {
            var buffer = new StringBuilder();
            var withColor = false;
            foreach (var s in args)
            {
                if (s == "--with-color")
                {
                    withColor = true;
                    continue;
                }
                buffer.Append(" ");
                buffer.Append(s);
            }

            return (buffer.ToString(), withColor);
        }

        private static string GetBot()
        {

            return @"
      __________________
                        \
                        \
                            ....
                            ....'
                            ....
                          ..........
                      .............'..'..
                  ................'..'.....
                .......'..........'..'..'....
                ........'..........'..'..'.....
              .'....'..'..........'..'.......'.
              .'..................'...   ......
              .  ......'.........         .....
              .                           ......
              ..    .            ..        ......
            ....       .                 .......
            ......  .......          ............
              ................  ......................
              ........................'................
            ......................'..'......    .......
          .........................'..'.....       .......
      ........    ..'.............'..'....      ..........
    ..'..'...      ...............'.......      ..........
    ...'......     ...... ..........  ......         .......
  ...........   .......              ........        ......
  .......        '...'.'.              '.'.'.'         ....
  .......       .....'..               ..'.....
    ..       ..........               ..'........
            ............               ..............
          .............               '..............
          ...........'..              .'.'............
        ...............              .'.'.............
        .............'..               ..'..'...........
        ...............                 .'..............
        .........                        ..............
          .....
  ";
        }
    }

    public static class ConsoleUtils
    {
        public static void PrintStringWithColor(string input, ConsoleColor color)
        {
            var tempColor = Console.ForegroundColor;
            Console.ForegroundColor = color;
            Console.WriteLine(input);
            Console.ForegroundColor = tempColor;
        }

        public static void PrintStringWithRandomColor(string input)
        {
            var line = string.Empty;
            var reader = new StringReader(input);
            var random = new Random();
            var index = random.Next(10) + 2;

            while ((line = reader.ReadLine()) != null)
            {
                index = (index % 14) + 2;
                var color = (ConsoleColor)index++;
                PrintStringWithColor(line, color);
            }
        }
    }
}
