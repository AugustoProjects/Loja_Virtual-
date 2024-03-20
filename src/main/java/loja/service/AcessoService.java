package loja.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import loja.model.Acesso;
import loja.repository.AcessoRepository;

@Service
public class AcessoService {

	
	@Autowired
	private AcessoRepository acessoRepository; 
	
	//pode fazer qualquer tipo de validação
	public Acesso save(Acesso acesso) {
		
		
		return acessoRepository.save(acesso) ;
		
	}
	
}
