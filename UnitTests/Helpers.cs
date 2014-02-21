using System;
using System.Text;

namespace EVident.UnitTests
{
    public class Helpers
    {
        public static string RandomString(int size)
        {
            StringBuilder builder = new StringBuilder();
            Random random = new Random();
            for (int i = 0; i < size; i++)
            {
                char ch = Convert.ToChar(Convert.ToInt32(Math.Floor(26 * random.NextDouble() + 65)));
                builder.Append(ch);
            }

            return builder.ToString();
        }
        public static string RandomNumber(int size)
        {
            Random random = new Random();
            string str = random.Next(1, 9).ToString();
            if (size > 1)
            {
                for (int i = 1; i < size; i++)
                {
                    str += random.Next(0, 9).ToString();
                }
            }
            return str;
        }
        public static string RandomNumber(int sizeleft, int sizeright)
        {
            Random random = new Random();
            string str = random.Next(1, 9).ToString();
            if (sizeleft > 0)
            {
                for (int i = 0; i < sizeleft; i++)
                {
                    str += random.Next(0, 9).ToString();
                }
            }
            if (sizeright > 0)
            {
                str += ",";
                for (int i = 0; i < sizeright; i++)
                {
                    str += random.Next(0, 9).ToString();
                }
            }
            return str;

        }

        public static string RandomNip()
        {
            string strippedNip = RandomNumber(9);
            int[] weights = new[] {6, 5, 7, 2, 3, 4, 5, 6, 7};
            int sum = 0;
            for (int i = 0; i < weights.Length; i++)
                sum += int.Parse(strippedNip.Substring(i, 1))*weights[i];
            strippedNip += (sum%11).ToString();
            return strippedNip;
        }
        public static string RandomRegon(int length)
        {
            string str = "";
            int sum = 0;
            if (length == 9)
            {
                str = RandomNumber(8);
                int[] weights = { 8, 9, 2, 3, 4, 5, 6, 7 };
                for (int i = 0; i < weights.Length; i++)
                    sum += int.Parse(str.Substring(i, 1)) * weights[i];
                int checkDigit = sum%11;
                if (checkDigit == 10) { str += "0"; }
                else { str += checkDigit.ToString(); }

            }
            if (length == 14)
            {
                str = RandomNumber(13);
                int[] weights = { 2, 4, 8, 5, 0, 9, 7, 3, 6, 1, 2, 4, 8 };
                for (int i = 0; i < weights.Length; i++)
                    sum += int.Parse(str.Substring(i, 1)) * weights[i];
                int checkDigit = sum % 11;
                str += checkDigit.ToString();
            }
            return str;
        }


    }
}