require 'rails_helper'

describe 'Dono de Buffet tenta editar um evento' do
  it 'sem ser o responsável por ele' do
    pix = PaymentMethod.create!(name: 'Pix')
    valet_service = ServiceOption.create!(name: 'Serviço de Valet')
    
    fernando = BuffetOwner.create!(
      email: 'contato@fernandotulipas.com', 
      password: 'fernandodastulipas123'
    )
    
    mr_alderson = BuffetOwner.create!(
      email: 'contato@mrobot.com', 
      password: '9PJNAmwW!@8fXPDUE'
    )    
    
    fernando_buffet = Buffet.create!(        
      trading_name: 'Buffet Tulipas - Villa Valentim', 
      company_name: 'Buffet Tulipas - Villa Valentim Ltda.',
      registration_number: '12345678000123', 
      phone: ' 1129663900', 
      email: 'contato@buffettulipas.com', 
      address: 'Rua Valentim Magalhães, 293',
      neighborhood: ' Alto da Mooca',
      state: 'SP', 
      city: 'São Paulo', 
      zipcode: '01234567',
      description: 'O Buffet Tulipas tem a satisfação de realizar com sucesso, casamentos, festas de debutantes, eventos corporativos, aniversários e bodas. Nossos belíssimos espaços, localizados no Alto da Mooca, são o cenário perfeito para o seu evento.',
      buffet_owner: fernando,
      payment_methods: [pix]
    )
    
    alderson_buffet = Buffet.create!(        
      trading_name: 'MR Robot Fake Buffet', 
      company_name: 'MR Robot Inc.',
      registration_number: '80001231234567', 
      phone: '3900112966', 
      email: 'contato@ecorp.com', 
      address: 'East 57th Street, 135',
      neighborhood: 'Midtown Manhattan',
      state: 'NY', 
      city: 'New York', 
      zipcode: '10022',
      description: '...',
      buffet_owner: mr_alderson,
      payment_methods: [pix]
    )    
    
    event = Event.create!(
      name: 'Casamento',
      description: 'Um dia especial para celebrar o amor e a união.',
      qty_min: 50,
      qty_max: 300,
      duration: 240,
      menu: 'Entrada: Canapés variados. Prato Principal: Salmão grelhado com molho de ervas. Sobremesa: Bolo de casamento e doces finos.',
      service_options: [valet_service],
      buffet: fernando_buffet
    )
    
    login_as mr_alderson, scope: :buffet_owner
    patch event_path(event.id), params: { event: { qty_min: 1 } }

    expect(response).to redirect_to owner_dashboard_path
  end 
end