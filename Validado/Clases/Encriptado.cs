using System;
using System.Collections.Generic;
using System.Web;
using System.IO;
using System.Text;
using System.Security.Cryptography;

namespace LicsuWeb.Validado.Clases
{
    public class Encriptado
    {
        public static TripleDESCryptoServiceProvider m_des = new TripleDESCryptoServiceProvider();
        // define the string handler
        public static UTF8Encoding m_utf8 = new UTF8Encoding();
        // define the local property arrays
        public static byte[] m_key;
        public static byte[] m_iv;
        static Encriptado()
        {
            byte[] key = {
		        241,
		        232,
		        223,
		        214,
		        205,
		        196,
		        187,
		        178,
		        169,
		        151,
		        141,
		        132,
		        123,
		        114,
		        105,
		        96,
		        87,
		        78,
		        69,
		        50,
		        41,
		        32,
		        23,
		        14
	        };
            byte[] iv = {
		        18,
		        27,
		        36,
		        45,
		        54,
		        63,
		        72,
		        81
	        };
            m_key = key;
            m_iv = iv;
        }

        public static byte[] Encrypt(byte[] input)
        {
            return Transform(input, m_des.CreateEncryptor(m_key, m_iv));
        }

        public static byte[] Decrypt(byte[] input)
        {
            return Transform(input, m_des.CreateDecryptor(m_key, m_iv));
        }

        public static string Encrypt(string text)
        {
            byte[] input = m_utf8.GetBytes(text);
            byte[] output = Transform(input, m_des.CreateEncryptor(m_key, m_iv));
            return Convert.ToBase64String(output);
        }

        public static string Decrypt(string text)
        {
            byte[] input = Convert.FromBase64String(text);
            byte[] output = Transform(input, m_des.CreateDecryptor(m_key, m_iv));
            return m_utf8.GetString(output);
        }

        public static byte[] Transform(byte[] input, ICryptoTransform CryptoTransform)
        {
            // create the necessary streams
            MemoryStream memStream = new MemoryStream();
            CryptoStream cryptStream = new CryptoStream(memStream, CryptoTransform, CryptoStreamMode.Write);
            // transform the bytes as requested
            cryptStream.Write(input, 0, input.Length);
            cryptStream.FlushFinalBlock();
            // Read the memory stream and convert it back into byte array
            memStream.Position = 0;
            byte[] result = new byte[Convert.ToInt32(memStream.Length - 1) + 1];
            memStream.Read(result, 0, Convert.ToInt32(result.Length));
            // close and release the streams
            memStream.Close();
            cryptStream.Close();
            // hand back the encrypted buffer
            return result;
        }
    }
}