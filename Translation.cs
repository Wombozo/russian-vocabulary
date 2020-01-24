using System;
using System.Collections.Generic;

namespace russian_vocabulary
{
    class Translation
    {
    private
        List<string> russian;
        List<string> french;
        int count = 0;
        public Translation()
        {
            russian = new List<string>();
            french = new List<string>();
        }
        ~Translation(){}
        public void Add(string fr,string rus)
        {
            french.Add(fr);
            russian.Add(rus);
            count++;
        }
        public string GetFrench(string rus)
        {
            var index = russian.IndexOf(rus);
            if (index == -1)
                return "(nil)";
            return french[index];
        }
        public string GetFrench(int c)
        {

            if (c >= count)
                return "(nil)";
            else
                return french[c];
        }
        public string GetRussian(string fr)
        {
            var index = russian.IndexOf(fr);
            if (index == -1)
                return "(nil)";
            return russian[index];
        }

        public string GetRussian(int c)
        {
            if (c >= count)
                return "(nil)";
            else
                return russian[c];
        }
        public void DisplayAll()
        {
            for (int c = 0; c < count; c++)
            {
                Console.WriteLine($"{french[c]} <-> {russian[c]}");
            }
        }
        public int GetRandomFrenchWord()
        {
            Random rnd = new Random();
            var index = rnd.Next(0,count);
            Console.WriteLine($"Russian word(s) for \"{french[index]}\" ?");
            return index;
        }
    };
}