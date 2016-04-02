<?php
class Instituicao {
	private $_id;
	private $_nome;
	private $_sigla;
	private $_morada;
	private $_contacto;
	
	public function __construct($array) {
		$this->_nome = $array[1];
		$this->_sigla = strtoupper($array[2]);
		$this->_morada = $array[3];
		$this->_contacto = $array[4];
		$this->_website = $array[5];
		$this->_imagem = $array[2];
	}

	public function getPage() {
		return "hub/$this->_imagem";
	}

	public function getNome() {
		return $this->_nome;
	}
	
	public function getSigla() {
		return $this->_sigla;
	}
		
	public function getMorada() {
		return $this->_morada;
	}
	
	public function getContacto() {
		return $this->_contacto;
	}

	public function getPaginaOficial() {
		return "https://sigarra.up.pt/$this->_imagem/pt/web_page.inicial";
	}

	public function getPaginaCursos() {
		return "https://sigarra.up.pt/$this->_imagem/pt/cur_geral.cur_inicio";
	}
		
	public function getImagem() {
		return "img/$this->_imagem.jpg";
	}
}