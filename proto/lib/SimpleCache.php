<?
class SimpleCache
{
	public $cache_path;
	public $cache_time = 86400;
	public $cache_extension = '.cache';

	public function __construct()
	{
		global $BASE_DIR;
		$this->cache_path = "{$BASE_DIR}cache/";
	}
  
	public function get_data($label)
	{
		if ($data = $this->get_cache(md5($label)))
		{
			return $data;
		}

		$query = urlencode($label);
		$url = "https://pt.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exsentences=2&exintro=&explaintext=&titles=$query";
		$this->set_cache(md5($label), $this->do_curl($url));

		return $data;
	}
  
	public function set_cache($label, $data)
	{
		file_put_contents($this->cache_path . $this->safe_filename($label) . $this->cache_extension, $data);
	}
  
	public function get_cache($label)
	{
		if (!$this->is_cached($label))
		{
			return false;
		}

		return file_get_contents($this->cache_path . $this->safe_filename($label) . $this->cache_extension);
	}
  
	public function is_cached($label)
	{
		return file_exists($this->cache_path . $this->safe_filename($label) . $this->cache_extension);
	}
  
	public function do_curl($url)
	{
		if (function_exists("curl_init"))
		{
			$ch = curl_init();
			curl_setopt($ch, CURLOPT_URL, $url);
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
			curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 5);
			$content = curl_exec($ch);
			curl_close($ch);
			return $content;
		}

		return file_get_contents($url);
	}

	private function safe_filename($filename)
	{
		return preg_replace('/[^0-9a-z\.\_\-]/i','', strtolower($filename));
	}
}
?>