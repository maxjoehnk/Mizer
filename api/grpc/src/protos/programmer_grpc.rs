// This file is generated. Do not edit
// @generated

// https://github.com/Manishearth/rust-clippy/issues/702
#![allow(unknown_lints)]
#![allow(clippy::all)]

#![cfg_attr(rustfmt, rustfmt_skip)]

#![allow(box_pointers)]
#![allow(dead_code)]
#![allow(missing_docs)]
#![allow(non_camel_case_types)]
#![allow(non_snake_case)]
#![allow(non_upper_case_globals)]
#![allow(trivial_casts)]
#![allow(unsafe_code)]
#![allow(unused_imports)]
#![allow(unused_results)]


// server interface

pub trait ProgrammerApi {
    fn subscribe_to_programmer(&self, req: ::grpc::ServerRequestSingle<super::programmer::SubscribeProgrammerRequest>, resp: ::grpc::ServerResponseSink<super::programmer::ProgrammerState>) -> ::grpc::Result<()>;

    fn write_control(&self, req: ::grpc::ServerRequestSingle<super::programmer::WriteControlRequest>, resp: ::grpc::ServerResponseUnarySink<super::programmer::WriteControlResponse>) -> ::grpc::Result<()>;

    fn select_fixtures(&self, req: ::grpc::ServerRequestSingle<super::programmer::SelectFixturesRequest>, resp: ::grpc::ServerResponseUnarySink<super::programmer::SelectFixturesResponse>) -> ::grpc::Result<()>;

    fn clear(&self, req: ::grpc::ServerRequestSingle<super::programmer::ClearRequest>, resp: ::grpc::ServerResponseUnarySink<super::programmer::ClearResponse>) -> ::grpc::Result<()>;

    fn highlight(&self, req: ::grpc::ServerRequestSingle<super::programmer::HighlightRequest>, resp: ::grpc::ServerResponseUnarySink<super::programmer::HighlightResponse>) -> ::grpc::Result<()>;

    fn store(&self, req: ::grpc::ServerRequestSingle<super::programmer::StoreRequest>, resp: ::grpc::ServerResponseUnarySink<super::programmer::StoreResponse>) -> ::grpc::Result<()>;

    fn get_presets(&self, req: ::grpc::ServerRequestSingle<super::programmer::PresetsRequest>, resp: ::grpc::ServerResponseUnarySink<super::programmer::Presets>) -> ::grpc::Result<()>;

    fn call_preset(&self, req: ::grpc::ServerRequestSingle<super::programmer::PresetId>, resp: ::grpc::ServerResponseUnarySink<super::programmer::CallPresetResponse>) -> ::grpc::Result<()>;

    fn get_groups(&self, req: ::grpc::ServerRequestSingle<super::programmer::GroupsRequest>, resp: ::grpc::ServerResponseUnarySink<super::programmer::Groups>) -> ::grpc::Result<()>;

    fn select_group(&self, req: ::grpc::ServerRequestSingle<super::programmer::SelectGroupRequest>, resp: ::grpc::ServerResponseUnarySink<super::programmer::SelectGroupResponse>) -> ::grpc::Result<()>;
}

// client

pub struct ProgrammerApiClient {
    grpc_client: ::std::sync::Arc<::grpc::Client>,
}

impl ::grpc::ClientStub for ProgrammerApiClient {
    fn with_client(grpc_client: ::std::sync::Arc<::grpc::Client>) -> Self {
        ProgrammerApiClient {
            grpc_client: grpc_client,
        }
    }
}

impl ProgrammerApiClient {
    pub fn subscribe_to_programmer(&self, o: ::grpc::RequestOptions, req: super::programmer::SubscribeProgrammerRequest) -> ::grpc::StreamingResponse<super::programmer::ProgrammerState> {
        let descriptor = ::grpc::rt::ArcOrStatic::Static(&::grpc::rt::MethodDescriptor {
            name: ::grpc::rt::StringOrStatic::Static("/mizer.programmer.ProgrammerApi/SubscribeToProgrammer"),
            streaming: ::grpc::rt::GrpcStreaming::ServerStreaming,
            req_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
            resp_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
        });
        self.grpc_client.call_server_streaming(o, req, descriptor)
    }

    pub fn write_control(&self, o: ::grpc::RequestOptions, req: super::programmer::WriteControlRequest) -> ::grpc::SingleResponse<super::programmer::WriteControlResponse> {
        let descriptor = ::grpc::rt::ArcOrStatic::Static(&::grpc::rt::MethodDescriptor {
            name: ::grpc::rt::StringOrStatic::Static("/mizer.programmer.ProgrammerApi/WriteControl"),
            streaming: ::grpc::rt::GrpcStreaming::Unary,
            req_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
            resp_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
        });
        self.grpc_client.call_unary(o, req, descriptor)
    }

    pub fn select_fixtures(&self, o: ::grpc::RequestOptions, req: super::programmer::SelectFixturesRequest) -> ::grpc::SingleResponse<super::programmer::SelectFixturesResponse> {
        let descriptor = ::grpc::rt::ArcOrStatic::Static(&::grpc::rt::MethodDescriptor {
            name: ::grpc::rt::StringOrStatic::Static("/mizer.programmer.ProgrammerApi/SelectFixtures"),
            streaming: ::grpc::rt::GrpcStreaming::Unary,
            req_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
            resp_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
        });
        self.grpc_client.call_unary(o, req, descriptor)
    }

    pub fn clear(&self, o: ::grpc::RequestOptions, req: super::programmer::ClearRequest) -> ::grpc::SingleResponse<super::programmer::ClearResponse> {
        let descriptor = ::grpc::rt::ArcOrStatic::Static(&::grpc::rt::MethodDescriptor {
            name: ::grpc::rt::StringOrStatic::Static("/mizer.programmer.ProgrammerApi/Clear"),
            streaming: ::grpc::rt::GrpcStreaming::Unary,
            req_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
            resp_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
        });
        self.grpc_client.call_unary(o, req, descriptor)
    }

    pub fn highlight(&self, o: ::grpc::RequestOptions, req: super::programmer::HighlightRequest) -> ::grpc::SingleResponse<super::programmer::HighlightResponse> {
        let descriptor = ::grpc::rt::ArcOrStatic::Static(&::grpc::rt::MethodDescriptor {
            name: ::grpc::rt::StringOrStatic::Static("/mizer.programmer.ProgrammerApi/Highlight"),
            streaming: ::grpc::rt::GrpcStreaming::Unary,
            req_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
            resp_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
        });
        self.grpc_client.call_unary(o, req, descriptor)
    }

    pub fn store(&self, o: ::grpc::RequestOptions, req: super::programmer::StoreRequest) -> ::grpc::SingleResponse<super::programmer::StoreResponse> {
        let descriptor = ::grpc::rt::ArcOrStatic::Static(&::grpc::rt::MethodDescriptor {
            name: ::grpc::rt::StringOrStatic::Static("/mizer.programmer.ProgrammerApi/Store"),
            streaming: ::grpc::rt::GrpcStreaming::Unary,
            req_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
            resp_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
        });
        self.grpc_client.call_unary(o, req, descriptor)
    }

    pub fn get_presets(&self, o: ::grpc::RequestOptions, req: super::programmer::PresetsRequest) -> ::grpc::SingleResponse<super::programmer::Presets> {
        let descriptor = ::grpc::rt::ArcOrStatic::Static(&::grpc::rt::MethodDescriptor {
            name: ::grpc::rt::StringOrStatic::Static("/mizer.programmer.ProgrammerApi/GetPresets"),
            streaming: ::grpc::rt::GrpcStreaming::Unary,
            req_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
            resp_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
        });
        self.grpc_client.call_unary(o, req, descriptor)
    }

    pub fn call_preset(&self, o: ::grpc::RequestOptions, req: super::programmer::PresetId) -> ::grpc::SingleResponse<super::programmer::CallPresetResponse> {
        let descriptor = ::grpc::rt::ArcOrStatic::Static(&::grpc::rt::MethodDescriptor {
            name: ::grpc::rt::StringOrStatic::Static("/mizer.programmer.ProgrammerApi/CallPreset"),
            streaming: ::grpc::rt::GrpcStreaming::Unary,
            req_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
            resp_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
        });
        self.grpc_client.call_unary(o, req, descriptor)
    }

    pub fn get_groups(&self, o: ::grpc::RequestOptions, req: super::programmer::GroupsRequest) -> ::grpc::SingleResponse<super::programmer::Groups> {
        let descriptor = ::grpc::rt::ArcOrStatic::Static(&::grpc::rt::MethodDescriptor {
            name: ::grpc::rt::StringOrStatic::Static("/mizer.programmer.ProgrammerApi/GetGroups"),
            streaming: ::grpc::rt::GrpcStreaming::Unary,
            req_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
            resp_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
        });
        self.grpc_client.call_unary(o, req, descriptor)
    }

    pub fn select_group(&self, o: ::grpc::RequestOptions, req: super::programmer::SelectGroupRequest) -> ::grpc::SingleResponse<super::programmer::SelectGroupResponse> {
        let descriptor = ::grpc::rt::ArcOrStatic::Static(&::grpc::rt::MethodDescriptor {
            name: ::grpc::rt::StringOrStatic::Static("/mizer.programmer.ProgrammerApi/SelectGroup"),
            streaming: ::grpc::rt::GrpcStreaming::Unary,
            req_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
            resp_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
        });
        self.grpc_client.call_unary(o, req, descriptor)
    }
}

// server

pub struct ProgrammerApiServer;


impl ProgrammerApiServer {
    pub fn new_service_def<H : ProgrammerApi + 'static + Sync + Send + 'static>(handler: H) -> ::grpc::rt::ServerServiceDefinition {
        let handler_arc = ::std::sync::Arc::new(handler);
        ::grpc::rt::ServerServiceDefinition::new("/mizer.programmer.ProgrammerApi",
            vec![
                ::grpc::rt::ServerMethod::new(
                    ::grpc::rt::ArcOrStatic::Static(&::grpc::rt::MethodDescriptor {
                        name: ::grpc::rt::StringOrStatic::Static("/mizer.programmer.ProgrammerApi/SubscribeToProgrammer"),
                        streaming: ::grpc::rt::GrpcStreaming::ServerStreaming,
                        req_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
                        resp_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
                    }),
                    {
                        let handler_copy = handler_arc.clone();
                        ::grpc::rt::MethodHandlerServerStreaming::new(move |req, resp| (*handler_copy).subscribe_to_programmer(req, resp))
                    },
                ),
                ::grpc::rt::ServerMethod::new(
                    ::grpc::rt::ArcOrStatic::Static(&::grpc::rt::MethodDescriptor {
                        name: ::grpc::rt::StringOrStatic::Static("/mizer.programmer.ProgrammerApi/WriteControl"),
                        streaming: ::grpc::rt::GrpcStreaming::Unary,
                        req_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
                        resp_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
                    }),
                    {
                        let handler_copy = handler_arc.clone();
                        ::grpc::rt::MethodHandlerUnary::new(move |req, resp| (*handler_copy).write_control(req, resp))
                    },
                ),
                ::grpc::rt::ServerMethod::new(
                    ::grpc::rt::ArcOrStatic::Static(&::grpc::rt::MethodDescriptor {
                        name: ::grpc::rt::StringOrStatic::Static("/mizer.programmer.ProgrammerApi/SelectFixtures"),
                        streaming: ::grpc::rt::GrpcStreaming::Unary,
                        req_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
                        resp_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
                    }),
                    {
                        let handler_copy = handler_arc.clone();
                        ::grpc::rt::MethodHandlerUnary::new(move |req, resp| (*handler_copy).select_fixtures(req, resp))
                    },
                ),
                ::grpc::rt::ServerMethod::new(
                    ::grpc::rt::ArcOrStatic::Static(&::grpc::rt::MethodDescriptor {
                        name: ::grpc::rt::StringOrStatic::Static("/mizer.programmer.ProgrammerApi/Clear"),
                        streaming: ::grpc::rt::GrpcStreaming::Unary,
                        req_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
                        resp_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
                    }),
                    {
                        let handler_copy = handler_arc.clone();
                        ::grpc::rt::MethodHandlerUnary::new(move |req, resp| (*handler_copy).clear(req, resp))
                    },
                ),
                ::grpc::rt::ServerMethod::new(
                    ::grpc::rt::ArcOrStatic::Static(&::grpc::rt::MethodDescriptor {
                        name: ::grpc::rt::StringOrStatic::Static("/mizer.programmer.ProgrammerApi/Highlight"),
                        streaming: ::grpc::rt::GrpcStreaming::Unary,
                        req_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
                        resp_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
                    }),
                    {
                        let handler_copy = handler_arc.clone();
                        ::grpc::rt::MethodHandlerUnary::new(move |req, resp| (*handler_copy).highlight(req, resp))
                    },
                ),
                ::grpc::rt::ServerMethod::new(
                    ::grpc::rt::ArcOrStatic::Static(&::grpc::rt::MethodDescriptor {
                        name: ::grpc::rt::StringOrStatic::Static("/mizer.programmer.ProgrammerApi/Store"),
                        streaming: ::grpc::rt::GrpcStreaming::Unary,
                        req_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
                        resp_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
                    }),
                    {
                        let handler_copy = handler_arc.clone();
                        ::grpc::rt::MethodHandlerUnary::new(move |req, resp| (*handler_copy).store(req, resp))
                    },
                ),
                ::grpc::rt::ServerMethod::new(
                    ::grpc::rt::ArcOrStatic::Static(&::grpc::rt::MethodDescriptor {
                        name: ::grpc::rt::StringOrStatic::Static("/mizer.programmer.ProgrammerApi/GetPresets"),
                        streaming: ::grpc::rt::GrpcStreaming::Unary,
                        req_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
                        resp_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
                    }),
                    {
                        let handler_copy = handler_arc.clone();
                        ::grpc::rt::MethodHandlerUnary::new(move |req, resp| (*handler_copy).get_presets(req, resp))
                    },
                ),
                ::grpc::rt::ServerMethod::new(
                    ::grpc::rt::ArcOrStatic::Static(&::grpc::rt::MethodDescriptor {
                        name: ::grpc::rt::StringOrStatic::Static("/mizer.programmer.ProgrammerApi/CallPreset"),
                        streaming: ::grpc::rt::GrpcStreaming::Unary,
                        req_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
                        resp_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
                    }),
                    {
                        let handler_copy = handler_arc.clone();
                        ::grpc::rt::MethodHandlerUnary::new(move |req, resp| (*handler_copy).call_preset(req, resp))
                    },
                ),
                ::grpc::rt::ServerMethod::new(
                    ::grpc::rt::ArcOrStatic::Static(&::grpc::rt::MethodDescriptor {
                        name: ::grpc::rt::StringOrStatic::Static("/mizer.programmer.ProgrammerApi/GetGroups"),
                        streaming: ::grpc::rt::GrpcStreaming::Unary,
                        req_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
                        resp_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
                    }),
                    {
                        let handler_copy = handler_arc.clone();
                        ::grpc::rt::MethodHandlerUnary::new(move |req, resp| (*handler_copy).get_groups(req, resp))
                    },
                ),
                ::grpc::rt::ServerMethod::new(
                    ::grpc::rt::ArcOrStatic::Static(&::grpc::rt::MethodDescriptor {
                        name: ::grpc::rt::StringOrStatic::Static("/mizer.programmer.ProgrammerApi/SelectGroup"),
                        streaming: ::grpc::rt::GrpcStreaming::Unary,
                        req_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
                        resp_marshaller: ::grpc::rt::ArcOrStatic::Static(&::grpc_protobuf::MarshallerProtobuf),
                    }),
                    {
                        let handler_copy = handler_arc.clone();
                        ::grpc::rt::MethodHandlerUnary::new(move |req, resp| (*handler_copy).select_group(req, resp))
                    },
                ),
            ],
        )
    }
}
