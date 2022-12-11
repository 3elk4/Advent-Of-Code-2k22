using System;
using System.IO;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Linq;

class Monkey
{
    public Queue<long> items;
    public string ops;
    public string opsValue; 
    public int inspectedItems = 0;
    public int mod;
    public int trueMonkey, falseMonkey;

    public long InspectItem(long item)
    {
        long opsValueInt = (opsValue == "old" ? item : Int64.Parse(opsValue));
        return ops == "*" ? item * opsValueInt : item + opsValueInt;
    }

    public int GetTargetMonkey(long item)
    {
       return item % mod == 0 ? trueMonkey : falseMonkey;
    }
}

class Program
{
    public static List<Monkey> Monkeys(string filename)
    {
        List<Monkey> monkeys = new List<Monkey>();

        using (StreamReader streamReader = new StreamReader(filename))
        {
            while (!streamReader.EndOfStream)
            {
                Monkey monkey = new Monkey();

                //number
                streamReader.ReadLine();

                //items
                Queue<long> items = new Queue<long>();
                var temp = streamReader.ReadLine().Trim().Split(" ");

                for (int i = 2; i < temp.Length; ++i) items.Enqueue(Int32.Parse(Regex.Match(temp[i], @"\d+").Value));
                monkey.items = items;

                // ops
                temp = streamReader.ReadLine().Trim().Split(" ");
                monkey.ops = temp[4];
                monkey.opsValue = temp[5];


                // test
                temp = streamReader.ReadLine().Trim().Split(" ");
                monkey.mod = Int32.Parse(temp[3]);

                temp = streamReader.ReadLine().Trim().Split(" ");
                monkey.trueMonkey = Int32.Parse(temp[5]);

                temp = streamReader.ReadLine().Trim().Split(" ");
                monkey.falseMonkey = Int32.Parse(temp[5]);

                streamReader.ReadLine(); // empty line
                monkeys.Add(monkey);
            }
        }

        return monkeys;
    }

    public static void StartThrowing(int rounds, List<Monkey> monkeys, Func<long, long> lowerStress)
    {
        for (int i = 0; i < rounds; ++i)
        {
            foreach (var monkey in monkeys)
            {
                while (monkey.items.Any())
                {
                    monkey.inspectedItems++;

                    var item = monkey.items.Dequeue();
                    item = lowerStress(monkey.InspectItem(item));

                    monkeys[monkey.GetTargetMonkey(item)].items.Enqueue(item);
                }
            }
        }
    }

    public static long Result(IEnumerable<Monkey> monkeys) =>
            monkeys
            .OrderByDescending(monkey => monkey.inspectedItems)
            .Take(2)
            .Aggregate(1L, (res, monkey) => res* monkey.inspectedItems);

    public static void Part1(string filename)
    {
        var monkeys = Monkeys(filename);
        StartThrowing(20, monkeys, (item) => item / 3);
        Console.WriteLine(Result(monkeys));
    }

    public static void Part2(string filename)
    {
        var monkeys = Monkeys(filename);
        var mod = monkeys.Aggregate(1, (mod, monkey) => mod * monkey.mod);
        StartThrowing(10000, monkeys, (item) => item % mod);
        Console.WriteLine(Result(monkeys));
    }

    public static void Main()
    {
        string filename = @"input.txt";
        Part1(filename);
        Part2(filename);
    }
}