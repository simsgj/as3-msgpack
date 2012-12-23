//
// as3-msgpack (MessagePack for Actionscript3)
// Copyright (C) 2012 Lucas Teixeira (Disturbed Coder)
//
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
package org.msgpack
{
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;

	/**
	 * MessagePack class. 
	 * @see TypeMap
	 */
	public class MessagePack
	{
		//
		// static attributes
		//
		/**
		 * Major version value.
		 */
		public static const MAJOR:uint = 0;
		/**
		 * Minor version value.
		 */
		public static const MINOR:uint = 5;
		/**
		 * Revision version value;
		 */
		public static const REVISION:uint = 0;

		/**
		 * Get full version as string.
		 * @return Full version string.
		 */
		public static function get VERSION():String
		{
			return MAJOR + "." + MINOR + "." + REVISION;
		}

		//
		// private attributes
		//
		private var _typeMap:TypeMap;


		//
		// constructor
		//
		/**
		 * Create a new instance of MessagePack capable of reading/writing data.
		 * @param _typeMap type map to be used by the new message pack object.
		 */
		public function MessagePack(_typeMap:TypeMap = null)
		{
			this._typeMap = _typeMap || TypeMap.global;
		}

		//
		// getters and setters
		//
		/**
		 * Get the type map associated to this object.
		 * @return TypeMap instance used by this instance.
		 * @see TypeMap
		 */
		public function get typeMap():TypeMap
		{
			return _typeMap;
		}

		//
		// public interface
		//
		/**
		 * Write an object into a output buffer.
		 * @param data Object to be encoded
		 * @param output Any object that implements IDataOutput interface (ByteArray, Socket, URLStream, etc).
		 * @return Return the buffer with the encoded bytes. If output parameter is null, a ByteArray instance is created, otherwise output parameter is returned.
		 */
		public function write(data:*, output:IDataOutput = null):*
		{
			if (!output)
				output = new ByteArray();

			_typeMap.encode(data, output);

			return output;
		}

		/**
		 * Write a buffer into a object.
		 * @param input Any object that implements IDataInput interface (ByteArray, Socket, URLStream, etc).
		 * @return Return the decoded object.
		 */
		public function read(input:IDataInput):*
		{
			return _typeMap.decode(input);
		}
	}
}