using System;

namespace russian_vocabulary
{
    class Program
    {
    public
        static void Main(string[] args)
        {
            Run();
        }

    private
        static void Run()
        {
            Translation t = new Translation();
            Builder b = new Builder(t);
            Console.WriteLine(t.GetRussian(0));
        }
    }
}
